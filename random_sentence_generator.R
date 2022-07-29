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

token <- rtweet::rtweet_bot(
  api_key       = consumerKey,
  api_secret    = consumerSecret,
  access_token  = accessToken,
  access_secret = accessTokenSecret
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

rtweet::post_tweet(
  status = post,
  token = token
)
