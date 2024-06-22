# Render one rep max shiny app ------------------------------------------------
#
# - renders one rep max shiny app
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_libs.R"))

# -----------------------------------------------------------------------------
shinylive::export(appdir = "shinyR_1rm_warmup_sets", 
                  destdir = here("shinyR_1rm_warmup_sets","docs")
)