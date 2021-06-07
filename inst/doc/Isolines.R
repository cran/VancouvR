## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = nzchar(Sys.getenv("COMPILE_VIG"))
)

## ----setup--------------------------------------------------------------------
library(ggplot2)
library(VancouvR)

## -----------------------------------------------------------------------------
ggplot(get_cov_data("elevation-contour-lines-1-metre-contours",format="geojson") ) + 
  geom_sf(aes(color=elevation),size=0.1) + 
  scale_color_viridis_c(option="inferno",guide=FALSE) + 
  theme_void()

