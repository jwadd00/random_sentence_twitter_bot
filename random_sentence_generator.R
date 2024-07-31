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

bot <- rtweet_bot(
  api_key = '7Le7jaqT2SS7UODgZ5XWudXvk',
  api_secret = 'nlZ0TqQDckxjeQfzjMQ7cIh41U0hCR8qk2vFUq9PQipUDFYq98',
  access_token = '276697001-IkmDMp5RrQ4j71rtSj8LRTxRhCo35XV7e73YPgX5',
  access_secret = ' SQEjuIZ5xYyD5JpoKpPoyam0XzjeW6BBKI8nh770P4jTa'
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

client <- rtweet_client(client_id = 'R0hPSFZOVnNiWllSYzhmTkFGQVk6MTpjaQ', app = 'Little Analysis Thing')
client_as(client)
client_save(client)
auth_as(bot)

if (FALSE) {
  # It requires the Oauth2.0 Authentication
   tp_id <- tweet_post(post)
   tweet_post()
 }

 rtweet_user(
  client_id = 'R0hPSFZOVnNiWllSYzhmTkFGQVk6MTpjaQ',
  client_secret = '3-kAksCU3bo-4-IR1P0UdBYAxs0imUpl3E4qyb20dsersJubCY'
)

tweet_post(paste0("My first tweet with #rtweet #rstats at ", Sys.time()))
