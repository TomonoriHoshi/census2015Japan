#### import population dataset ####
library(readxl)
library(tidyverse)
dir.create("data/census", recursive = T)

# website 
# https://www.e-stat.go.jp/stat-search/files?page=1&layout=datalist&toukei=00200521&tstat=000001049104&cycle=0&tclass1=000001049105&stat_infid=000031594311
# 
# データセット情報
# 国勢調査 / 都道府県・市区町村別統計表（国勢調査） / 都道府県・市区町村別統計表（男女別人口，年齢３区分・割合，就業者，昼間人口など）
url <- "https://www.e-stat.go.jp/stat-search/file-download?statInfId=000031594311&fileKind=0"
download.file(url, "data/census/census_2015.xls", mode = "wb")
census2015 <- read_xls("data/census/census_2015.xls", range = "G11:BB1976", col_types = c("text", "text", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                             "numeric", "numeric", "numeric"))


## update names 
names(census2015)[3:39] <- read_xls("data/census/census_2015.xls", skip = 8) %>% names() %>% .[9:45]
names(census2015)[40:48] <- read_xls("data/census/census_2015.xls", skip = 9) %>% names() %>% .[46:54]
comment(census2015) <- "国勢調査 / 都道府県・市区町村別統計表（国勢調査） / 都道府県・市区町村別統計表（男女別人口，年齢３区分・割合，就業者，昼間人口など）"

# website 
# https://www.soumu.go.jp/main_sosiki/jichi_gyousei/daityo/jinkou_jinkoudoutai-setaisuu.html
# 
# 【総計】平成31年住民基本台帳人口・世帯数、平成30年人口動態（都道府県別）EXCEL
url <- "https://www.soumu.go.jp/main_content/000633315.xls"
download.file(url, "data/census/000633315_dat.xls", mode = "wb")
pref.pop <- read_xls("data/census/000633315_dat.xls", skip = 3)
names(pref.pop)[1:2] <- read_xls("data/census/000633315_dat.xls", skip = 1) %>% names() %>% .[1:2]
names(pref.pop)[c(6, 19:24)] <- read_xls("data/census/000633315_dat.xls", skip = 2) %>% names() %>% .[c(6, 19:24)]
names(pref.pop)[c(11, 17)]  <- read_xls("data/census/000633315_dat.xls", skip = 2) %>% names() %>% .[c(7, 13)] %>% paste("その他（計）")
comment(pref.pop) <- "【総計】平成31年住民基本台帳人口・世帯数、平成30年人口動態（都道府県別）"

# 【総計】平成31年住民基本台帳年齢階級別人口（都道府県別）EXCEL
url <- "https://www.soumu.go.jp/main_content/000633316.xls"
download.file(url, "data/census/000633316_dat.xls", mode = "wb")
pref.age <- read_xls("data/census/000633316_dat.xls", skip = 1)
comment(pref.age) <- "【総計】平成31年住民基本台帳年齢階級別人口（都道府県別）"

# 【総計】平成31年住民基本台帳人口・世帯数、平成30年人口動態（市区町村別）EXCEL
url <- "https://www.soumu.go.jp/main_content/000633317.xls"
download.file(url, "data/census/000633317_dat.xls", mode = "wb")
city.pop <- read_xls("data/census/000633317_dat.xls", skip = 3)
names(city.pop)[1:3] <- read_xls("data/census/000633317_dat.xls", skip = 1) %>% names() %>% .[1:3]
names(city.pop)[c(7, 20:25)] <- read_xls("data/census/000633317_dat.xls", skip = 2) %>% names() %>% .[c(7, 20:25)]
names(city.pop)[c(12, 18)] <- read_xls("data/census/000633317_dat.xls", skip = 2) %>% names() %>% .[c(8, 14)] %>% paste("その他（計）")
comment(city.pop) <- "【総計】平成31年住民基本台帳人口・世帯数、平成30年人口動態（市区町村別）"

# 【総計】平成31年住民基本台帳年齢階級別人口（市区町村別）
url <- "https://www.soumu.go.jp/main_content/000633318.xls"
download.file(url, "data/census/000633318_dat.xls", mode = "wb")
city.age <- read_xls("data/census/000633318_dat.xls", skip = 1)
comment(city.age) <- "【総計】平成31年住民基本台帳年齢階級別人口（市区町村別）"

## drop temp datasets
rm(url)

# show datasets
eapply(.GlobalEnv, comment)