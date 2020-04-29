setwd(dirname(rstudioapi::getSourceEditorContext()$path))


#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_AUT_1_sf.rds",
#              "AUT_adm1.rds", mode = "wb")
at = readRDS("AUT_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_CZE_1_sf.rds",
#              "CZK_adm1.rds", mode = "wb")
cz = readRDS("CZK_adm1.rds")


#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_HUN_1_sf.rds",
#              "HUN_adm1.rds", mode = "wb")
hu = readRDS("HUN_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_POL_1_sf.rds",
#              "PLN_adm1.rds", mode = "wb")
pl = readRDS("PLN_adm1.rds")


#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_SVK_1_sf.rds",
#              "SVK_adm1.rds", mode = "wb")
sk = readRDS("SVK_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_SVN_1_sf.rds",
#              "SVN_adm1.rds", mode = "wb")
sv = readRDS("SVN_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_HRV_1_sf.rds",
#              "HRV_adm1.rds", mode = "wb")
hr = readRDS("HRV_adm1.rds")


#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_ROU_1_sf.rds",
#              "ROU_adm1.rds", mode = "wb")
ro = readRDS("ROU_adm1.rds")


#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_SRB_1_sf.rds",
#              "SRB_adm1.rds", mode = "wb")
sr = readRDS("SRB_adm1.rds")

#download.file("https://biogeo.ucdavis.edu/data/gadm3.6/Rsf/gadm36_XKO_1_sf.rds",
#              "XKO_adm1.rds", mode = "wb")
ko = readRDS("XKO_adm1.rds")
