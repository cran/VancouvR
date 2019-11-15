## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(VancouvR)
library(dplyr)
library(tidyr)
library(ggplot2)

## ------------------------------------------------------------------------
search_cov_datasets("property") %>%
  select(dataset_id,title) %>%
  tail(10)

## ------------------------------------------------------------------------
get_cov_metadata("property-tax-report") %>%
  tail(10)

## ------------------------------------------------------------------------
aggregate_cov_data("property-tax-report",
                   group_by="tax_assessment_year as Year",
                   where="zone_name like 'RS-'",
                   select="sum(current_land_value) as Land, sum(current_improvement_value) as Building") %>% 
  mutate(Date=as.Date(paste0(as.integer(Year)-1,"-07-01"))) %>%
  pivot_longer(c("Land","Building")) %>%
  ggplot(aes(x=Year,y=value,color=name,group=name)) +
  geom_line() +
  scale_y_continuous(labels=function(x)paste0("$",x/1000000000,"Bn")) +
  labs(title="City of Vancouver RS zoned land values",color="",y="Aggregate value (nominal)")

## ------------------------------------------------------------------------
tax_data <- get_cov_data(dataset_id = "property-tax-report",
                         where="tax_assessment_year=2019",
                         select = "current_land_value, land_coordinate as tax_coord")
property_polygons <- get_cov_data(dataset_id="property-parcel-polygons",format = "geojson")

## ------------------------------------------------------------------------
plot_data <- property_polygons %>% 
  left_join(tax_data %>% group_by(tax_coord) %>% summarize(current_land_value=sum(current_land_value)),by="tax_coord") %>%
  mutate(rlv=current_land_value/as.numeric(sf::st_area(geometry))) %>%
  mutate(rlvd=cut(rlv,breaks=c(-Inf,1000,2000,3000,4000,5000,7500,10000,25000,50000,Inf),
                  labels=c("<$1k","$1k-$2k","$2k-$3k","$3k-$4k","$4k-$5k","$5k-$7.5k","$7.5k-$10k","$10k-$25k","$25k-$50k",">$50k"),
                  ordered_result = TRUE))
ggplot(plot_data) +
  geom_sf(aes(fill=rlvd),color=NA) +
  scale_fill_viridis_d(option="magma",na.value="darkgrey") +
  labs(title="2019 relative land values",fill="Value per m^2",caption="CoV Open Data") +
  coord_sf(datum=NA)
