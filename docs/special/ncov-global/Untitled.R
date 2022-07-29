library(readxl)
library(tidyverse)
library(httr)
library(scales)
extrafont::loadfonts()
library(dplyr)

# plot theme --------------------------------------------------------------

theme_set(
  theme_bw()+
    theme(text = element_text(family = 'Source Han Serif SC'),
          plot.title = element_text(hjust = 0.5))
)

color_scale <- scale_color_brewer(palette = "Paired")

# getting data ------------------------------------------------------------

GET("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", authenticate(":", ":", type="ntlm"), write_disk(tf <- tempfile(fileext = ".csv")))
data <- read_csv(tf)
ncov_new_cases <- data %>% 
  transmute(date=lubridate::dmy(dateRep), 
            cases = cases,
            deaths = deaths,
            location = countriesAndTerritories,
            id = geoId,
            pop = popData2018) %>% 
  mutate(location = str_replace_all(location, '_', " "))


# helper functions --------------------------------------------------------

find_country <- function(query) {
  unique(ncov_new_cases$location) %>% 
    str_match(regex(query, ignore_case = TRUE)) %>% 
    subset(!is.na(.))
}

# plot config -------------------------------------------------------------

selected_locations <- c(
  "United States of America",
  "China",
  "Italy",
  "United Kingdom",
  "Japan",
  "South Korea",
  #"Iran",
  #"Germany",
  #"Spain",
  #"France",
  "Singapore"
)


ncov_cumulative <- ncov_new_cases %>% 
  arrange(id, date) %>% 
  group_by(location) %>% 
  mutate(cases = cumsum(cases), deaths = cumsum(cases)) %>% 
  ungroup()

mkfit <- function(n, rate, a0=100) {
  tibble(
    x = 0:n,
    y = sapply(0:n, function(n) a0 * rate^n)
  )
}

since_100 <-  function(df, column){
  df %>% 
    dplyr::filter(eval(parse(text = column)) >= 100) %>% 
    group_by(location) %>% 
    mutate(date = as.integer(date - first(date)))
}



ncov_cumulative %>%
  dplyr::filter(location %in% selected_locations) %>% 
  since_100('cases') %>% 
  ggplot()+
  geom_line(aes(date, cases, color=location))+
  geom_line(data=mkfit(32, 1.3), aes(x, y), linetype='dashed')+
  geom_text(data = NULL, aes(x = 30, y = 120000, label='dashed line: daily 30% increase'), family="Source Han Serif SC")+
  scale_y_log10(labels = scales::comma)+
  color_scale+
  xlab('days since reported cases reaching 100')+
  ylab('reported cases')+
  labs(title = 'Growth of Reported COVID-19 Cases After Reaching 100',
       caption = 'Author: Tianyi Shi\nSource: European Centre for Disease Prevention and Control',
       color='country')

ggsave('~/Downloads/ncov-global.png', width = 15, height = 10, scale = 0.8)


# All

all_new_cases <- ncov_new_cases %>% 
  group_by(date) %>% 
  summarise(cases = sum(cases))

ncov_new_cases %>% 
  ggplot(aes(date, cases))+
  geom_line(aes(group=id))+
  geom_line(data = filter(ncov_new_cases, id=="CN"), aes(date, cases), color='red')+
  geom_line(data = filter(ncov_new_cases, id=="UK"), aes(date, cases), color='green')+
  geom_line(data = all_new_cases)

ncov_new_cases %>% 
  group_by(date) %>% 
  summarise(cases = sum(cases)) %>% 
  ggplot(aes(date, cases))+
  geom_line()

