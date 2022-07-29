library(tidyverse)
library(lubridate)
library(scales)
library(RColorBrewer)
library(maps)
library(mapdata)
library(maptools)

# themes ------------------------------------------------------------------

theme_default <- theme_bw() + theme(text = element_text(family = 'Source Han Serif SC'),
                       plot.margin = margin(0.7, 0.3, 0.7, 0.3, 'cm'),
                       plot.title = element_text(hjust = 0.5, size = 20),
                       plot.subtitle = element_text(hjust = 0.5, size = 18),
                       legend.text = element_text(size = 11),
                       legend.title = element_text(size = 13),
                       plot.caption = element_text(hjust = 0))

theme_date <- theme_bw() + theme_default + 
  theme(axis.text.x = element_text(angle = 40, hjust = 1))

theme_map <- theme_void() + theme_default

# colors ------------------------------------------------------------------

{ # provice (34)
  getPallete = colorRampPalette(brewer.pal(8, "Set3"))
  fill_province <- scale_fill_manual(values=getPallete(34))
}

fill_map <- scale_fill_brewer(palette = 'Reds', na.value='white')


# scales ------------------------------------------------------------------

dateScale = scale_x_date(labels = date_format("%Y-%m-%d"), date_breaks = '5 day', date_minor_breaks = '1 day')
