known %>% 
  filter(antigen_amount<=1000) %>% 
  ggplot(aes(antigen_amount, count))+
  geom_point()+
  geom_smooth(span=0.9)+
  theme_bw()
