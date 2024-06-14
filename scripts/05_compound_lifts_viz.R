# Compound lift viz ----------------------------------------------------------
#
# - Visualize progress for compound lifts bench press,
# - squats, and deadlifts
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_libs.R"))

# -----------------------------------------------------------------------------

# load data with relevant cols
routine <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ') %>%
  transmute(
    exercise,
    set_number = factor(set_number),
    weight,
    date,
    reps_completed
  )

# create df for bench
bench_press <- routine %>%
  filter(
    exercise == "bench_press"
  )

# create df for squat
squat <- routine %>%
  filter(
    exercise == "squat_barbell"
  )

# create df for deadlift
deadlift <- routine %>%
  filter(
    exercise == "deadlift"
  )

# bench press viz
bench_press_viz <- bench_press %>%
  ggplot(
    aes(x = date, y = weight, color = set_number)
  ) +
  geom_point(size = 3) +
  geom_line() +
  geom_text(aes(label = reps_completed), 
            vjust = -.05, 
            hjust = 1.4,
            size = 3,
            color = "black") +
  labs(
    title = "Bench Press Performance",
    x = "Date",
    y = "Weight (lbs)",
    color = "Set number"
  )
bench_press_viz

# squat viz
squat_viz <- squat %>%
  ggplot(
    aes(x = date, y = weight, color = set_number)
  ) +
  geom_point(size = 3) +
  geom_line() +
  geom_text(aes(label = reps_completed), 
            vjust = -.05, 
            hjust = 1.4,
            size = 3,
            color = "black") +
  labs(
    title = "Squat Performance",
    x = "Date",
    y = "Weight (lbs)",
    color = "Set number"
  )

# deadlift viz
deadlift_viz <- deadlift %>%
  ggplot(
    aes(x = date, y = weight, color = set_number)
  ) +
  geom_point(size = 3) +
  geom_line() +
  geom_text(aes(label = reps_completed), 
            vjust = -.05, 
            hjust = 1.4,
            size = 3,
            color = "black") +
  labs(
    title = "Deadlift Performance",
    x = "Date",
    y = "Weight (lbs)",
    color = "Set number"
  )