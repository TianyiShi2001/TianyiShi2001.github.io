p <- ncov %>% 
  ggplot(aes(date, deathRate))+
  geom_line(aes(group=location), alpha=0.2)+
  geom_line(data = ncovByHubei %>% drop_na(), aes(color=type))+
  scale_alpha_continuous(guide=FALSE)+
  scale_y_continuous(limits = c(0,0.15), minor_breaks = seq(0, 0.15, 0.01), labels = scales::percent)+
  theme_default+
  dateScale+
  labs(title='死亡率趋势图', x='日期',y='死亡率',
       color = '地区',
       caption = '注：黑/灰色线为各省/市/区死亡率趋势，累计病例数表现为线条深浅。')+
  scale_color_manual(values=hubeiContrastColor)

ggsave('img/china_death_rate.svg', width = 13, height = 8)


ncov %$%
  date %>% length()
