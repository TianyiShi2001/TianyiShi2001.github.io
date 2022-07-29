setwd('/Users/tianyishi/Documents/GitHub/ox/content/bioinformatics/src/pdb')

library(tidyverse)
library(lubridate)
# theme -------------------------------------------------------------------

p = 'Set1'
color <-  list(scale_color_brewer(palette = p),scale_fill_brewer(palette = p))

theme_set(
  theme_bw()+
  theme(
    text = element_text(family = 'Courier'),
    plot.title = element_text(hjust = 0.5)
  )
)

library("scales")
reverselog_trans <- function(base = exp(1)) {
  trans <- function(x) -log(x, base)
  inv <- function(x) base^(-x)
  trans_new(paste0("reverselog-", format(base)), trans, inv, 
            log_breaks(base = base), 
            domain = c(1e-100, Inf))
}

# tidy data ---------------------------------------------------------------

pdb <- read_csv('date_method_resolution.csv',
                col_names = c('id', 'date', 'resolution', 'method'),
                col_types = 'ccdc') %>% 
  mutate(date = dmy(date)) %>% 
  filter(!is.na(resolution))

single_method <- pdb %>% filter(!str_detect(method, ';'))
multiple_method <- pdb %>% filter(str_detect(method, ';'))

# pdb <- bind_rows(single_method, do.call(bind_rows, 
#                                         lapply(1:length(multiple_method[[1]]),function(i) {
#                                           original_row = multiple_method[i,]
#                                           do.call(bind_rows, 
#                                                   lapply(str_split(original_row[['method']], '; ')[[1]], function(m){
#                                                     mutate(original_row, method=m)
#                                                   }
#                                                   )
#                                           )
#                                         }
#                                         )
# ))

pdb <- bind_rows(single_method, do.call(bind_rows, 
  lapply(1:length(multiple_method[[1]]),function(i) {
    original_row = multiple_method[i,]
    mutate(original_row, method=str_split(original_row[['method']], '; ')[[1]][1])
    }
  )
))

# apply(multiple_method, 1, function(row){
#   lapply(str_split(row['method'], "; ")[[1]], function(method){
#     bind_rows(pdb, mutate(row, method=method))
#   })
# })


# plot --------------------------------------------------------------------

ggplot(filter(pdb), aes(method, resolution, fill=method))+
  geom_violin(alpha=1)+
  guides(colour = guide_legend(override.aes = list(alpha=1)))+
  labs(title = 'Violin')+
  coord_flip()+
  guides(fill = guide_legend(reverse = TRUE))+
  scale_y_log10(minor_breaks = c(1:10, seq(10, 100, 10), seq(0.1, 1, 0.1)))+
  color

{ #fit
  ggplot(filter(pdb, method =='ELECTRON MICROSCOPY', date>ymd(20000101), resolution < 20), aes(date, resolution))+
    geom_point(alpha=0.1)+
    labs(title = 'Resolution of EM Structures Over Time')+
    scale_y_continuous(limits = c(0, 20), breaks = c(2, 3, 4, seq(0, 20, 5)), minor_breaks = c(7.5, 12.5, 17.5, seq(2, 5, 0.5)))+
    geom_smooth(method = 'lm')
  
  ggsave('plot/overtime-em.png', width = 10, height = 7, dpi = 400, scale = 1) 
  
  
  ggplot(filter(pdb, method =='X-RAY DIFFRACTION'), aes(date, resolution))+
    geom_point(alpha=0.1)+
    scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, 2), minor_breaks = c(seq(1,9,2), seq(1,3,0.1)))+
    geom_smooth(method = 'lm')+
    labs(title = 'Resolution of X-Ray Crystallography Structures Over Time')
  
  ggsave('plot/overtime-x-ray.png', width = 10, height = 7, dpi = 400, scale = 1) 
}

{ # boxplots
  boxPlotScale = scale_y_continuous(minor_breaks = c(1:10, seq(10, 100, 10), seq(0.1, 1, 0.1)), breaks=c(0.5, 1, 2, 3, 5, 10, 20, 60), trans=reverselog_trans(10))
  
  ggplot(mutate(pdb, year = year(date)), aes(year, resolution, group=year))+
    geom_boxplot()+
    facet_wrap(~method)+
    boxPlotScale+
    scale_x_reverse()+
    coord_flip()+
    labs(title = 'Comparison of Resolution of Different Methods Over Time')
  
  ggsave('plot/hist_all.png', width = 30, height = 25, dpi = 300, scale = 0.6)
    
  ggplot(mutate(pdb, year = year(date)) %>% filter(method %in% c('X-RAY DIFFRACTION', 'ELECTRON MICROSCOPY')), aes(year, resolution, group=year))+
    geom_boxplot()+
    facet_wrap(~method, ncol = 1)+
    boxPlotScale+
    labs(title = 'Comparison of Resolution of EM and X-Ray Crystallography Over Time')
  
  ggsave('plot/hist_2.png', width = 20, height = 20, dpi = 300, scale = 0.6) 
}

{
  pdb %>% mutate(year = year(date)) %>% 
  group_by(year, method) %>% 
  summarise(
    median = median(resolution, na.rm = TRUE),
    n = n()) %>% 
  mutate( alpha = ifelse(method=='X-RAY DIFFRACTION', 'A', 'B')) %>% 
  ggplot(aes(year, median, color=method, size=log(n), alpha=alpha))+
  geom_point()+
  scale_y_continuous(breaks = seq(0,25,5))+
  scale_alpha_discrete(range=c(0.7, 0.9), guide=FALSE)+
  labs(title='Median Resolution of Different Methods Over Time')+
  scale_color_brewer(palette = 'Set2')
  
  ggsave('plot/dot.png', width = 20, height = 14, dpi = 300, scale = 0.6) 
}


