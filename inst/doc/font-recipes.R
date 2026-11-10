## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# library(gdtools)
# font_set_liberation()

## ----eval=FALSE---------------------------------------------------------------
# font_set_auto()

## ----eval=FALSE---------------------------------------------------------------
# library(munch)
# library(ggplot2)
# 
# fonts <- font_set(sans = font_google("Open Sans"))
# 
# ggplot(mtcars, aes(mpg, wt)) +
#   geom_point() +
#   labs(title = "**Open Sans** via *font_set()*") +
#   theme_minimal(base_family = fonts$sans) +
#   theme(plot.title = element_md())

## -----------------------------------------------------------------------------
library(gdtools)

# Found by measurement (systemfonts + registry)?
font_family_exists("sans")

# Installed at the system level?
font_family_exists("sans", system_only = TRUE)

