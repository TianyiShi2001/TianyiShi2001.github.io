file <- '/Users/tianyishi/Downloads/TM_WORLD_BORDERS-0/TM_WORLD_BORDERS-0.3.shp'

library(tidyverse)
library(lubridate)
library(scales)
library(RColorBrewer)
library(maps)
library(mapdata)
library(maptools)

wmap <- rgdal::readOGR(file)

shape <- broom::tidy(wmap) %>%
  mutate(id = as.integer(id), long = round(long, 2), lat = round(lat, 2)) %>%
  select(long, lat, group, id)
country_id <- data.frame(wmap@data, id = 0:(length(wmap@data[[1]])-1)) %>%
  select(id, NAME)
map_data <- full_join(shape, country_id, by = 'id')

m1 <- map_data %>% 
  filter(lat>-58)

cases_by_country <- readxl::read_excel('/Users/tianyishi/Documents/GitHub/ox/content/special/data/wuhan.xlsx', sheet = 'global') %>% 
  filter(date == as_date(cdate)) %>% 
  gather(NAME, cases, -1) %>% select(NAME, cases)

plot_data <- full_join(m1, cases_by_country)

ggplot(plot_data,aes(x=long,y=lat,group=group, fill=cases))+
  geom_polygon(colour='grey')+
  coord_quickmap()+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_gradient2(midpoint = 125, low = 'white', mid = 'red', high = 'black', na.value = 'white')+
  theme_bw()
