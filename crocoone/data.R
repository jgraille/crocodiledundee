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
if (!exists("tweetstesla")) tweetstesla <- readRDS(file = "./data/tweetstesla.rda")
tweetstesla <- tweetstesla[tweetstesla$created_at >= 2020-03-08,]

data("stop_words")
other <- data.frame(word=other_stop_words, stringsAsFactors = FALSE)
other$lexicon <- as.character("other")
stop_words <- bind_rows(stop_words, other)

noisefrequency <- tweetstesla %>% 
  select("text") %>%
  tidytext::unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE) %>%
  mutate(proportion = n / sum(n)) %>%
  inner_join(get_sentiments(lexicon = c("bing", "afinn", "loughran", "nrc")))











