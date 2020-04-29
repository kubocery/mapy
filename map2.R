rm(list=ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
require(tidyverse)
require(viridis)

#source('data.R')

df <- readRDS('mapdata.rds')

df$value <- as.numeric(as.character(df$value))

source('data2.R')


pl1 <- ggplot(df) +
  geom_sf(aes(fill = value, geometry = geometry), color = "grey50", size = 0.5)+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = at %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = cz %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = hu %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = sk %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = pl %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = hr %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = sv %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = sr %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  geom_sf(fill = "transparent", color = "black", size = 0.5, 
          data = ro %>% group_by(GID_0) %>% summarise(), mapping = aes(geometry = geometry))+
  theme_classic()+
  scale_fill_viridis(option = "magma", direction = -1,name = "Exposure to PM2.5\nmicrograms", 
                     guide = guide_colorbar(direction = "vertical",
                       barheight = unit(70, units = "mm"),
                       barwidth = unit(10, units = "mm"),
                       draw.ulim = F,
                       title.position = 'top',
                       #title.hjust = 0.5,
                       label.hjust = 0.5))+
  theme(
    axis.line = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    legend.position = c(0.9,0.7),
    #legend.title = element_text(hjust = 0.5),
    legend.title.align=0.5)

require(cowplot)
pl2 <- ggdraw(align_legend(pl1))
source('align_title.R')
#plot(pl1)
ggsave('map1.png', plot = pl2, width = 11, height = 9)
