rm(list=ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

require(xlsx)
require(tidyverse)

df <- read.xlsx2('emisie.xlsx', startRow = 6, endRow = 181, sheetIndex = 1)
df <- df[-1,]

df2 <- data.frame(Country = df$Year, NUTS2 = df$X., value = df$X2017)
df2[df2$Country=='',1]<-NA
df2 <- df2 %>% fill(Country) %>% filter(NUTS2 !='-Total-')
df2$value <- as.numeric(as.character(df2$value))
df2$Country <- as.character(df2$Country)
df2$NUTS2 <-  trimws(as.character(df2$NUTS2))
extra <- c("Romania", 'Ilfov', df2$value[df2$NUTS2=='Bucuresti'])
df2 <- rbind(df2,extra)


#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_AUT_1_sf.rds",
#              "AUT_adm1.rds", mode = "wb")
at = readRDS("AUT_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_CZE_1_sf.rds",
#              "CZK_adm1.rds", mode = "wb")
cz = readRDS("CZK_adm1.rds")

cz$NAME_1[c(3,10)] <- 'Zapadocesky' 
cz$NAME_1[c(4,5,9)]<-  'Vychodocesky'
cz$NAME_1[c(6,13)]<-  'Severocesky'
cz$NAME_1[c(7,8,14)]<-  'Severomoravsky'
cz$NAME_1[c(11)]<-  'Praha'



#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_HUN_1_sf.rds",
#              "HUN_adm1.rds", mode = "wb")
hu = readRDS("HUN_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_POL_1_sf.rds",
#              "PLN_adm1.rds", mode = "wb")
pl = readRDS("PLN_adm1.rds")

pl$NAME_1[pl$NAME_1=="Zachodniopomorskie"] <- "Zachodnio-Pomorskie"

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_SVK_1_sf.rds",
#              "SVK_adm1.rds", mode = "wb")
sk = readRDS("SVK_adm1.rds")
sk$VARNAME_1[is.na(sk$VARNAME_1)]<-'Presov'
sk$NAME_1 <- sk$VARNAME_1

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_SVN_1_sf.rds",
#              "SVN_adm1.rds", mode = "wb")
sv = readRDS("SVN_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_HRV_1_sf.rds",
#              "HRV_adm1.rds", mode = "wb")
hr = readRDS("HRV_adm1.rds")
hro <- hr %>% select(-geometry)
hr$VARNAME_1[is.na(hr$VARNAME_1)]<- 'Grad zagreb'
hr$VARNAME_1[hr$VARNAME_1=='Slavonski Brod-Posavina']<- 'Slavonski Brod-Posav'
hr$VARNAME_1[hr$VARNAME_1=='Split-Dalmacia']<- 'Split-Dalmatija'
hr$VARNAME_1[hr$VARNAME_1=='Varaždin|Varasd']<- 'varazdin'
hr$NAME_1 <- hr$VARNAME_1

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_ROU_1_sf.rds",
#              "ROU_adm1.rds", mode = "wb")
ro = readRDS("ROU_adm1.rds")

ro$NAME_1[ro$NAME_1=='Bucharest']<- 'Bucuresti'

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_SRB_1_sf.rds",
#              "SRB_adm1.rds", mode = "wb")
sr = readRDS("SRB_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_XKO_1_sf.rds",
#              "XKO_adm1.rds", mode = "wb")
ko = readRDS("XKO_adm1.rds")


dfm <- rbind(at,cz,hr,hu,pl,ro,sk,sr,sv,ko)

dfm2 <- dfm %>% select(GID_0, NAME_0, NAME_1, geometry)

require(fuzzyjoin)
library(stringi)
dfm2$NAME_1 <- stri_trans_general(dfm2$NAME_1, "Latin-ASCII")
df2$NUTS2 <- trimws(df2$NUTS2)
#dfm2$NAME_1[27]<- 'Istra'
df2$NUTS2 <- tolower(df2$NUTS2)
dfm2$NAME_1 <- tolower(dfm2$NAME_1)
pok <- dplyr::select(dfm2, -geometry)
pok1 <- df2 %>% stringdist_left_join(.,dfm2, by = c('NUTS2' = 'NAME_1' ),max_dist = 1)

pok2 <- pok1[!is.na(pok1$NAME_1),]

pok2 %>% filter(Country=='Croatia') %>% select(-geometry)->aaa
#pok2 <- distinct(pok2)

saveRDS(pok2,'mapdata.rds')

