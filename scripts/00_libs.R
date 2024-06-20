# Load libraries --------------------------------------------------------------
library('stringr')
library('tidyverse')
library('here')
library('brms')
library('ggdist')
library('googlesheets4')
library('ggrepel')
library('plotly')
# -----------------------------------------------------------------------------

# Load data -------------------------------------------------------------------
routine <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ')
# -----------------------------------------------------------------------------