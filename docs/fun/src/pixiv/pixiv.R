setwd('content/fun/src/pixiv/')

library(tidyverse)
library(jsonlite)
library(lubridate)
raw <- read_json('pixiv_parsed.json', simplifyVector = TRUE) %>%
  as_tibble() %>%
  mutate(date=anytime::anytime(date, tz="UTC") %>% as_datetime())


raw %>% 
  ggplot(aes(view, bookmark))+
  geom_point()

d <- tibble(tags = raw$tags %>% unlist()) %>%
  group_by(tags) %>%
  summarise(n = n()) %>%
  filter(!str_detect(tags, "users"))

d %>% arrange(-n) %>%
  slice(1:20) %>%
  ggplot(aes(fct_reorder(tags, n), n)) +
  geom_col()+
  coord_flip()+
  theme_bw()+
  theme(text = element_text(family = 'Source Han Serif SC'))

jsonlite::write_json(d, path = 'freq.json', simplifyVector=TRUE)

setwd('../../../..')
