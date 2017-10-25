library(tidyverse)
library(rvest)
library(httr)

url = "http://samhda.s3-us-gov-west-1.amazonaws.com/s3fs-public/field-uploads/2k15StateFiles/NSDUHsaeShortTermCHG2015.htm"
drug_use_xml = read_html(url)

drug_use_xml
drug_use_xml %>%
  html_nodes(css = "table")

table_marj = (drug_use_xml %>% html_nodes(css = "table"))[[1]] %>%
  html_table() %>%
  .[-1,] %>%  #take out the first row ?
  as_tibble()


## test
url = "https://www.bestplaces.net/cost_of_living/city/new_york/new_york"
options(rpubs.upload.method = "internal")
cost_ny_xml = read_html(url)
cost_ny_xml %>%
  html_nodes(css = "table")


hpss_html = read_html("http://www.imdb.com/title/tt0241527/")
cast = hpss_html %>%
  html_nodes(".itemprop .itemprop") %>%
  html_text()
cast


url = "https://www.amazon.com/Philips-Sonicare-rechargeable-toothbrush-HX6211/product-reviews/B00YAR7ZFM/ref=cm_cr_arp_d_viewopt_srt?ie=UTF8&reviewerType=all_reviews&sortBy=recent&pageNumber=1"
toothbrush_xml = read_html(url)

toothbrush_titles = toothbrush_xml %>%
  html_nodes("#cm_cr-review_list .review-title") %>%
  html_text()

toothbrush_stars = toothbrush_xml %>%
  html_nodes("#cm_cr-review_list .review-rating") %>%
  html_text()

toothbrush_df = data.frame(
  title = toothbrush_titles,
  stars = toothbrush_stars,
)


# use httr package
nyc_water = GET("https://data.cityofnewyork.us/resource/waf7-5gvc.csv") %>% 
  content("parsed")

# getting the same data using json

nyc_water = GET("https://data.cityofnewyork.us/resource/waf7-5gvc.json") %>% 
  content("text") %>%
  jsonlite::fromJSON() %>% 
  as_tibble()

brfss = 
  GET("https://chronicdata.cdc.gov/api/views/hn4x-zwk7/rows.csv?accessType=DOWNLOAD") %>% 
  content("parsed")  # use csv type directly

poke = GET("http://pokeapi.co/api/v2/pokemon/1") %>%
  content()

poke$abilities
# data is not always in a typical csv