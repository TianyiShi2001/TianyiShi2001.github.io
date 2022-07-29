library(R.matlab)
library(reshape2)
library(tidyverse)
setwd('/Users/tianyishi/Documents/GitHub/ox/content/lab/src/Y2T3W7-genomics')


# load data ---------------------------------------------------------------

H3K4me3 <- readMat('H3K4me3_ChIP_seq_glucose_gene_levels.mat')$H3K4me3.ChIP.seq.glucose.gene.levels
MNase <- readMat('MNase_seq_glucose_gene_levels.mat')$MNase.seq.glucose.gene.levels
NET <- readMat('NET_seq_glucose_gene_levels_sense_strand.mat')$NET.seq.glucose.gene.levels.sense.strand
NET[NET < -0.5 | NET > 5] = NA

# heat map ----------------------------------------------------------------

plot_heatmap <- function(mat, title) {
  return(
    mat %>% 
    melt() %>% 
    ggplot(aes(Var2, Var1, fill=value))+
      geom_tile()+
      scale_x_continuous(expand = c(0,0), breaks = c(1, 501, 1001, 1501), labels = c('-500', 'TSS', '+500', '+1000'))+
      scale_y_continuous(expand = c(0,0))+
      scale_fill_gradient(low="blue", high = "yellow")+
      labs(title=title,
           x='Position relative to TSS (bp)',
           y='Gene number')
  )
}

plot_heatmap(MNase, "MNase seq Glucose")
ggsave('MNase_seq_glucose_gene_levels.png', width = 10, height = 10, dpi = 300, scale = 0.8)

plot_heatmap(H3K4me3, 'H3K4me3 ChIP-seq Glucose')
ggsave('H3K4me3_ChIP_seq_glucose_gene.png', width = 10, height = 10, dpi = 300, scale = 0.8)

plot_heatmap(NET, 'NET-seq Glucose sense strand')
ggsave('NET_seq_glucose_gene_levels_sense_strand.png')


# average -----------------------------------------------------------------

xylabs <- labs(x='Position relative to TSS (bp)', y='average NET-seq level')
xaxis <- scale_x_continuous(breaks = c(0, 500, 1000, 1500), labels = c('-500', 'TSS', '+500', '+1000'))

# Average gene profile MNase-seq Glucose
tibble(x=0:1500, y=apply(MNase, 2, mean)) %>% 
  ggplot(aes(x, y))+
  geom_line()+
  xaxis+
  xylabs+
  labs(title='Average gene profile MNase-seq Glucose')

# NET-seq data highest and lowest H3K4me3 comparison
tibble() %>% 
  bind_rows(tibble(x=0:1500, y=apply(NET[1:501,], 2, mean)) %>% add_column(`H3K4me3 level`='high')) %>% 
  bind_rows(tibble(x=0:1500, y=apply(NET[4501:5000,], 2, mean)) %>% add_column(`H3K4me3 level`='low')) %>%
  ggplot(aes(x, y, color=`H3K4me3 level`))+
    geom_line()+
    xylabs+xaxis+
    labs(title='NET-seq data highest and lowest H3K4me3 comparison')

