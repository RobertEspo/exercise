#  Body weight stats viz ------------------------------------------------------
#
# - Some viz for body weight stats
#
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here::here("scripts", "01_helper_load_data.R"))

# -----------------------------------------------------------------------------

# pivot longer
weight_and_muscle <- weight_stats %>% select(
  date,
  weight_lb,
  muscle_mass,
  lean_body_mass
) %>%
  pivot_longer(
  cols = c(weight_lb, muscle_mass, lean_body_mass),
  names_to = "variable",
  values_to = "values"
)

# viz lean body mass, muscle mass, body weight over time
viz_weight_muscle <- weight_and_muscle %>% ggplot(aes(
  x = date,
  y = values,
  color = variable
)) +
  geom_smooth() +
  geom_point(size = 3) +
  labs(
    title = "Weight Stats Over Time",
    x = "date",
    y = "weight (lb)",
    color = "Measurement"
  ) +
  scale_color_manual(
    labels = c("Lean Body Mass", "Muscle Mass", "Body Weight"),
    values = c("blue", "red", "green")
  )