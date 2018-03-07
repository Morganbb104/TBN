#https://www.gbif.org/developer/summary
#在R中使用GBIF的套件
#package'rgbif'   https://cran.r-project.org/web/packages/rgbif/rgbif.pdf
# https://goo.gl/KNEfqd



##### * Set up environment #####
install.packages('rgbif')
library(rgbif)

##### * Search and download GBIF data #####
# hard limit 200,000 records

##### ** by dataset key #####
##### *** get dataset key #####
ds = dataset_search(query = "breeding bird", return = 'data')
ds[ds$publishingCountry == 'TW', c('datasetKey', 'datasetTitle')]
##### *** get data by dataset key and return specific dwc fields #####
occ_search(datasetKey='f170f056-3f8a-4ef3-ac9f-4503cc854ce0', fields=c('decimalLatitude','decimalLongitude'))

##### ** by species #####
##### *** get taxon key #####
suggested = name_suggest(q='Lonicera japonica', rank='species')
txnKey = suggested$key[1]
# or
matched = name_backbone(name = 'Passer montanus', rank='species', kingdom = 'Animalia')
txnKey = matched$usageKey

##### *** get data by scientific name (synonyms included) with all fields #####
occ_df = occ_search(scientificName = 'Passer montanus', fields = 'all')
##### --- get data by taxon key and return with minimal set of fields
occ_df = occ_search(taxonKey = txnKey, fields = 'minimal')

##### ** by geospatial info #####
##### *** get data by country isocode #####
occ_search(country = 'TW', limit = 10)

##### *** get data inside polygon (WKT format) and filter out data with geospatial issues #####
# get polygon wkt from https://arthur-e.github.io/Wicket/sandbox-gmaps3.html
wkt = "POLYGON((121.57181535637557 25.24528423172286,121.58039842522322 25.24497369924205,121.58932481682479 25.23907343133304,121.595847949149 25.227272036252536,121.60408769524275 25.225408553371548,121.60477434075057 25.217643734042277,121.59481798088729 25.21143152173948,121.59447465813338 25.19962744472079,121.61404405510604 25.18782222325644,121.62983690178572 25.164208348552087,121.63704667961775 25.14338706080887,121.60855089104354 25.13313049396327,121.59962449944197 25.113236515260912,121.57456193840682 25.11976458405701,121.58245836174666 25.13468457462121,121.5793684569615 25.147116507852278,121.56872545159041 25.14183309091138,121.55018602287947 25.13996830092392,121.52787004387557 25.141211497413735,121.5134504882115 25.138725091775168,121.48186479485213 25.170422969608506,121.48907457268416 25.186268819463972,121.49937425530135 25.189686281662027,121.5024641600865 25.201491322450362,121.51928697502791 25.2117421398869,121.52752672112166 25.208325296661176,121.53061662590682 25.217643734042277,121.54400621330916 25.22261327551345,121.54400621330916 25.238452333837117,121.55327592766463 25.245594763410057,121.57181535637557 25.24528423172286))"
ym_mnt = occ_search(geometry = wkt, hasGeospatialIssue = F)

##### *** get data by location name #####
two_places_ = occ_search(locality = c("Taipei", "JiJi"), fields = 'minimal')
two_places = rbind(two_places_$Taipei$data, two_places_$JiJi$data)

##### ** by temporal info #####
##### *** get data within year range #####
from2016to2016 = occ_search(year='2016,2017', country = 'TW')

##### ** draw a simple map with downloaded data #####
install.packages('maps')
# get usable region names
# unique(ggplot2::map_data("world")$region)
# draw map
gbifmap(input = two_places, region = "Taiwan")