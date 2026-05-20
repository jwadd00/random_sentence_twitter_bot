# package management
library(dplyr)
library(janitor)
library(rtweet)
library(glue)
library(lexicon)

# set up twitter auth
consumerKey <- Sys.getenv("TWITTER_APP_CONSUMER_KEY")
consumerSecret <- Sys.getenv("TWITTER_APP_CONSUMER_SECRET")
accessToken <- Sys.getenv("TWITTER_APP_ACCESS_TOKEN")
accessTokenSecret <- Sys.getenv("TWITTER_APP_ACCESS_TOKEN_SECRET")

# Retrieve API credentials from environment variables
api_key <- Sys.getenv("TWITTER_API_KEY")
api_secret <- Sys.getenv("TWITTER_API_SECRET")
access_token <- Sys.getenv("TWITTER_ACCESS_TOKEN")
access_secret <- Sys.getenv("TWITTER_ACCESS_SECRET")

# Validate that all credentials are set
if (api_key == "" || api_secret == "" || access_token == "" || access_secret == "") {
  stop("Missing Twitter API credentials. Please set environment variables.")
}

bot <- rtweet_bot(
  api_key = api_key,
  api_secret = api_secret,
  access_token = access_token,
  access_secret = access_secret
)

# nouns
irregular_nouns <- lexicon::pos_df_irregular_nouns %>% 
  clean_names() %>%
  filter(!singular %in% c('child', 'panties', 'baby', 'die', 'dwarf', 'louse', 'man', 'offspring', 'person','woman', 'wife', 'beau','ovum')) %>% 
  select(singular) %>% 
  pull()

# verbs
verbs <- lexicon::pos_action_verb

# names
names <- lexicon::common_names

# post
post <- glue("Never underestimate the willingness of a ", sample(irregular_nouns, 1), " named ", sample(names, 1), " to ", sample(verbs, 1), ' ', 'a ', sample(irregular_nouns, 1),
             "\n\n[-_-]random sentence generator built by jake\n[-_-]version 0.1 platinum deluxe 3000 \n[-_-]using: R Code and GitHub Actions")

post

rtweet::tweet_post(post)

client_id <- Sys.getenv("TWITTER_CLIENT_ID")
client <- rtweet_client(client_id = client_id, app = 'Little Analysis Thing')
client_as(client)
client_save(client)
auth_as(bot)

if (FALSE) {
  # It requires the Oauth2.0 Authentication
   tp_id <- tweet_post(post)
   tweet_post()
 }

client_secret <- Sys.getenv("TWITTER_CLIENT_SECRET")
rtweet_user(
  client_id = client_id,
  client_secret = client_secret
)

tweet_post(paste0("My first tweet with #rtweet #rstats at ", Sys.time()))
