#  Protein intake and body weight stats viz ------------------------------------
#
# - A viz that shows predicted protein intake and actual protein intake
#
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here::here("scripts", "01_helper_load_data.R"))

# -----------------------------------------------------------------------------

# remove na rows
viz_protein <- protein %>% 
  na.omit() %>%
  # select date, protein_intake, protein_goal
  select(
  date,
  protein_intake,
  protein_goal
) %>%
  # pivot longer
  pivot_longer(
    cols = c(protein_intake, protein_goal),
    names_to = "variable",
    values_to = "values"
  ) %>%
  # plot
  ggplot(aes(x=date, y = values, color = variable)) +
  geom_smooth(se = FALSE) +
  geom_point(size = 3) +
  scale_color_manual(name = "Protein",
                     values = c("red","green"),
                     labels = c("goal", "intake")
  ) +
  labs(
    title = "Protein Goals and Intakes Over Time",
    x = "Date",
    y = "Protein (g)"
  )

viz_protein