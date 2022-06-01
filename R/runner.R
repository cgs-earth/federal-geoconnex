require(sf)
require(dplyr)
options(scipen=999)

get_oaf <- function(url,limit){
  l <- limit
  offset <- 0
  d <- sf::read_sf(paste0(url,"?offset=",offset,"&limit=",limit)) 
  d <- mutate(d,across(-geometry, as.character))
  while(l == limit){
    offset = offset + limit
    d2 <- sf::read_sf(paste0(url,"?offset=",offset,"&limit=",limit))
    d2 <- mutate(d2, across(-geometry, as.character))
    l <- length(d2$id)
   try(d <- dplyr::bind_rows(d,d2))
    print(offset)
  }
  return(d)
}

url <- "https://federal-geoconnex-eaxlzxprna-uc.a.run.app/collections"
c <- jsonlite::fromJSON(url)$collections
c$name <- gsub("/","-",c$id)

for(i in 6:length(c$id)) {
  u <- paste0(url,"/",c$id[i],"/items")
  data <- get_oaf(u,2000)
  sf::write_sf(data,paste0("../out/",c$name[i],".geojson"))
}
