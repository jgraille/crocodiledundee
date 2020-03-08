##### Loading dependencies #####
source("./global/dependencies.R")
#################################

##### Loading tokens, keys #####
source("global/token.R")
################################

##### Loading config #####
source("./global/config.R")
##########################

################################ Token Authentification ##############################
token <- get_token()
if (!exists("token")) token <- rtweet::create_token(app = "CrocodileDundee",
                                                    consumer_key = api_key,
                                                    consumer_secret = api_secret_key,
                                                    access_token = access_token,
                                                    access_secret = access_token_secret
                                                    )
rm(token)
#######################################################################################
if (!exists("tweetssearch")) tweetssearch <- readRDS(file = "./data/tweetssearch.rda")
if (!exists("tweetstimeline")) tweetstimeline <- readRDS(file = "./data/tweetstimeline.rda")

tweetssearch <- tweetssearch[tweetssearch$created_at > "2020-03-05", ]

data("stop_words")
other <- data.frame(word=other_stop_words, stringsAsFactors = FALSE)
other$lexicon <- as.character("other")
stop_words <- bind_rows(stop_words, other)

noisefrequency <- tweetssearch %>% 
  select("text") %>%
  tidytext::unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE) %>%
  mutate(proportion = n / sum(n))


