# Compound lifts viz ----------------------------------------------------------
#
# - Visualize progress for compound lifts bench press,
# - squats, and deadlifts
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here("scripts","01_helper_load_data.R"))

# -----------------------------------------------------------------------------

### load data

# load data with relevant cols
compound_lifts <- routine %>%
  transmute(
    exercise,
    set_number = factor(set_number),
    weight,
    date,
    reps_completed
  )


### create dfs for each lift

# create df for bench
bench_press <- compound_lifts %>%
  filter(
    exercise == "bench_press"
  )

# create df for squat
squat <- compound_lifts %>%
  filter(
    exercise == "squat_barbell"
  )

# create df for deadlift
deadlift <- compound_lifts %>%
  filter(
    exercise == "deadlift"
  )


### 2D viz for each lift
### floating numbers are # of reps

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

### 3D viz for each lift

# bench press viz
plot_ly(bench_press,
        x = ~date, 
        y = ~reps_completed, 
        z = ~weight,
        color = ~factor(set_number), 
        type = "scatter3d", 
        mode = "lines+markers") %>%
  layout(scene = list(
    xaxis = list(title = "Date"),
    yaxis = list(title = "Reps Completed", autorange = "reversed", 
                 tickmode = "linear", tick0 = 0, dtick = 1),
    zaxis = list(title = "Weight (lbs)")
  ),
  legend = list(title = list(text = "Set Number"))
  )

# squat viz
plot_ly(squat,
        x = ~date, 
        y = ~reps_completed, 
        z = ~weight,
        color = ~factor(set_number), 
        type = "scatter3d", 
        mode = "lines+markers") %>%
  layout(scene = list(
    xaxis = list(title = "Date"),
    yaxis = list(title = "Reps Completed", autorange = "reversed", 
                 tickmode = "linear", tick0 = 0, dtick = 1),
    zaxis = list(title = "Weight (lbs)")
  ),
  legend = list(title = list(text = "Set Number"))
  )

# deadlift viz
plot_ly(deadlift,
        x = ~date, 
        y = ~reps_completed, 
        z = ~weight,
        color = ~factor(set_number), 
        type = "scatter3d", 
        mode = "lines+markers") %>%
  layout(scene = list(
    xaxis = list(title = "Date"),
    yaxis = list(title = "Reps Completed", autorange = "reversed", 
                 tickmode = "linear", tick0 = 0, dtick = 1),
    zaxis = list(title = "Weight (lbs)")
  ),
  legend = list(title = list(text = "Set Number"))
  )
