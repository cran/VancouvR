## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = nzchar(Sys.getenv("COMPILE_VIG"))
)

## ----setup--------------------------------------------------------------------
library(ggplot2)
library(VancouvR)

## -----------------------------------------------------------------------------
contours <- get_cov_data("elevation-contour-lines-1-metre-contours")
class(contours)  # "sf" "data.frame"

## -----------------------------------------------------------------------------
ggplot(contours) +
  geom_sf(aes(color=elevation), size=0.1) +
  scale_color_viridis_c(option="inferno", guide="none") +
  theme_void()

## -----------------------------------------------------------------------------
get_cov_metadata("elevation-contour-lines-1-metre-contours") |>
  dplyr::filter(type == "geo_shape")

