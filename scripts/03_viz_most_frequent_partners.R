# Most frequent partners ------------------------------------------------------
#
# - See who I go to the gym with most frequently
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here("scripts","01_helper_load_data.R"))

# -----------------------------------------------------------------------------
partners_freq_viz <- routine %>%
  select(
    date,
    partner_id
  ) %>%
  distinct(date, .keep_all = TRUE) %>%
  # change partner ID codes to names
  left_join(partner_key, by = c("partner_id" = "partner_id")
            ) %>%
  group_by(partner) %>%
  summarize(count = n()) %>%
  ggplot(
    aes(x = partner, y = count)
    ) +
  geom_bar(stat ="identity")

partners_freq_viz
