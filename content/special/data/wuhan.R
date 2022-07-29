if('content' %in% dir()){setwd('content/special/data')}

source('ncov_commons.R')

# data --------------------------------------------------------------------

china_virus <- readxl::read_excel('wuhan.xlsx', sheet = 'incidence') %>% 
  select(-全国) %>% 
  mutate(date = as_date(date)) %>% 
  gather('location', 'cases', -1) %>% 
  mutate(location=as_factor(location))

quanguo <- china_virus %>% 
  group_by(date) %>% 
  summarise(cases = sum(cases, na.rm = TRUE))


# date --------------------------------------------------------------------

cdate <- as.character(as_date(now()))

date_cn <- strftime(cdate, '截至%Y年%m月%d日')
date_en <- strftime(cdate, 'as of %b %d, %Y')

# over time ---------------------------------------------------------------

ggplot(china_virus, aes(date, cases))+
  geom_col(aes(fill=fct_reorder(location, cases, last)))+
  # geom_smooth(data=quanguo, width=0.3, span=0.5)+
  scale_x_date(labels = date_format("%Y-%m-%d"), date_breaks = '1 day')+
  scale_y_continuous(expand = c(0, 1))+
  scale_fill_manual(values=getPallete(length(unique(china_virus$location))))+
  labs(title = '中国境内新型冠状病毒感染的肺炎疫情报告', subtitle = date_cn, caption = '数据来源：各地卫生健康委员会\n制图者：石天熠', x = '报告日期', y = '病例数量', fill='地区')+
  geom_text(aes(y=cases*1.5, label=""))+ # blank space
  theme_col

ggsave('img/wuhan_stat_cn.png', width = 17, height = 10)

# map ---------------------------------------------------------------------

# china_map <- rgdal::readOGR('china_map/bou2_4p.shp')
# shape <- broom::tidy(china_map) %>%
#   mutate(id = as.integer(id), long = round(long, 2), lat = round(lat, 2)) %>%
#   select(long, lat, group, id)
# provice_id <- data.frame(china_map@data, id = 0:924) %>%
#   mutate(location = iconv(NAME,"GBK", "UTF-8")) %>%
#   select(id, location)
# china_map_data <- full_join(shape, provice_id, by = 'id')
# write_csv(china_map_data, 'china_map/china_map.csv')
{
china_map_data = read_csv('china_map/china_map.csv')
capital <- read_csv('shenghui/capital.csv')

calc_severity <- function(x){
  if(is.na(x)){
    return(NA)
  } else if(x <= 10){
      return('1~10')
  } else if(x <= 100){
      return('11~100')
  } else if(x <= 1000){
    return('101~1000')
  } else{return('>1000')}
}

today <- china_virus %>% 
  filter(date == as_date(cdate)) %>% 
  mutate(severity=sapply(cases, calc_severity)) %>% 
  mutate(severity=factor(severity, levels = c('1~10', '11~100', '101~1000', '>1000'))) 
  
today_capital <- inner_join(today, capital, by = c('location' = 'name'))

plot_data <- full_join(china_map_data, today)

ggplot(plot_data,aes(x=long,y=lat))+
  geom_polygon(aes(group=group, fill=severity), colour='grey')+
  coord_map('polyconic')+
  # geom_point(aes(size=cases), data=today_capital, color = 'black')+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0), limits = c(18, 54))+
  #scale_fill_gradient2(midpoint = 125, low = 'white', mid = 'red', high = 'black', na.value = 'white')+
  col_map+
  labs(title = '2019-nCoV疫情地图', subtitle = date_cn, caption = '来源：各地卫生健康委员会\n作者：石天熠', fill = '病例数')+
  theme_map
  
ggsave(paste0('img/', cdate, '-map_cn.png'), width = 13, height = 10)

ggplot(plot_data,aes(x=long,y=lat,group=group, fill=severity))+
  geom_polygon(colour='grey')+
  coord_map('polyconic')+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0), limits = c(18, 54))+
  col_map+
  labs(title = '2019-nCoV Incidence Map (China)', subtitle = date_en, caption = 'Data Source: Respective Health Commisions\nAuthor: Tianyi Shi', fill = 'cases')+
  theme_map

ggsave(paste0('img/', cdate, '-map_en.png'), width = 13, height = 10)

ggplot(plot_data,aes(x=long,y=lat,group=group, fill=severity))+
  geom_polygon(colour='grey')+
  coord_map('polyconic')+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0), limits = c(18, 54))+
  col_map+
  labs(fill = 'cases')+
  theme_map

ggsave(paste0('img/', cdate, '-map.png'), width = 13, height = 8)
}

setwd('../../..')

