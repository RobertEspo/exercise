# Most frequent partners ------------------------------------------------------
#
# - See who I go to the gym with most frequently
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_libs.R"))

# -----------------------------------------------------------------------------

routine <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ') %>%
  select(
    day,
    partner
  ) %>%
  distinct(day, .keep_all = TRUE) %>%
  transmute(
    partner = ifelse(partner == 0, "alone",
                     ifelse(partner == 1, "Cristian",
                            ifelse(partner == 2, "Jordan",
                                   ifelse(partner == 3, "Jon",
                                          ifelse(partner == 4, "Jon_and_Jordan", 
                                                 ifelse(partner == 5, "Jon_and_Luis", NA)))))),
    day
  )

partner_counts <- routine %>%
  group_by(partner) %>%
  summarize(count = n())
