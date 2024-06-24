# Load data -------------------------------------------------------------------

# NOTE: Make sure that "routine" is the left-most tab 
# in the Google Sheets spreadsheet.

time <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ', 
                   sheet = "time")

compound_1rm_weekly <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ',
                          sheet = "compound_weekly_max_weights")

weight_stats <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ',
                           sheet = "weight") %>%
  # fix time col
  mutate(
    time = format(time, "%H:%M")
  )

schedule <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ',
                       sheet = "schedule")

routine <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ',
                      sheet = "routine")

protein <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ',
                      sheet = "protein")

partner_key <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ',
                          sheet = "partners")
# -----------------------------------------------------------------------------