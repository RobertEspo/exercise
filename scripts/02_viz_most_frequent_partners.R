# Most frequent partners ------------------------------------------------------
#
# - See who I go to the gym with most frequently
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_libs.R"))

# -----------------------------------------------------------------------------

# load data and select cols
# rename values from codes to partner names
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
                                                 ifelse(partner == 5, "Jon_and_Luis",
                                                        ifelse(partner == 6, "Luis", NA))))))),
    day
  )

# partner counts in df
partner_counts <- routine %>%
  group_by(partner) %>%
  summarize(count = n())

# bar plot partner counts
partner_counts <- routine %>% ggplot(
  aes(x = partner)
) +
  geom_bar()