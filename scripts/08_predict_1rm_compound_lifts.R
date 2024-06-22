# One rep max for compound lifts viz ------------------------------------------
#
# - Predict and visualize one rep max 
# - for compound lifts bench press, squats, and deadlifts
# - as well as warm up sets.
#
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here("scripts","01_helper_load_data.R"))

# -----------------------------------------------------------------------------

# load data
compound_lifts <- routine %>%
  # select exercise, set number, weight, reps completed
  transmute(
    exercise,
    weight,
    reps_completed,
    gym_day_count,
  ) %>%
  # filter for compound lifts
  filter(
    exercise %in% c("bench_press","squat_barbell","deadlift"),
    # filter to make sure no failed attempts are included
    reps_completed > 0
  ) %>%
# add one_rep_max col using Epley formula
# 1rm = w(1 + r/30)
# w = weight, r = # of reps completed
  mutate(
    # Bryzcki formula
    # one_rep_max = weight / (1.0278 - 0.0278 * reps_completed),
    
    # Epley formula
    one_rep_max = (reps_completed * weight * 0.0333) + weight,
    
    # add col for statistical weights
    # if reps_completed == 1, it will have a high weight
    # otherwise, earlier days will have lower weights
    stat_weights = ifelse(reps_completed == 1, 10, 1 / gym_day_count)
  ) %>%
  group_by(exercise) %>%
  summarize(one_rep_max_average = weighted.mean(one_rep_max, w = stat_weights))

### warm up sets for one rep maxes

## bench press

# extract one rep max prediction
bench_mean <- compound_lifts %>%
  filter(exercise == "bench_press") %>%
  pull(one_rep_max_average)

# create df for warm up sets
bench <- data.frame(
  exercise = "bench_press",
  set_num = seq(1,5,1),
  weight = c(0.5 * bench_mean, 
             0.6 * bench_mean,
             0.75 * bench_mean,
             0.85 * bench_mean,
             bench_mean),
  reps = factor(c(10, 5, 3, 2, 1))
)

## squat

# extract one rep max prediction
squat_mean <- compound_lifts %>%
  filter(exercise == "squat_barbell") %>%
  pull(one_rep_max_average)

# create df for warm up sets
squat <- data.frame(
  exercise = "squat_barbell",
  set_num = seq(1,5,1),
  weight = c(0.5 * squat_mean, 
             0.6 * squat_mean,
             0.75 * squat_mean,
             0.85 * squat_mean,
             squat_mean),
  reps = factor(c(10, 5, 3, 2, 1))
)

## deadlift

# extract one rep max prediction
deadlift_mean <- compound_lifts %>%
  filter(exercise == "deadlift") %>%
  pull(one_rep_max_average)

# create df for warm up sets
deadlift <- data.frame(
  exercise = "deadlift",
  set_num = seq(1,5,1),
  weight = c(0.5 * deadlift_mean, 
             0.6 * deadlift_mean,
             0.75 * deadlift_mean,
             0.85 * deadlift_mean,
             deadlift_mean),
  reps = factor(c(10, 5, 3, 2, 1))
)

### join warm up sets dfs
warm_up_sets <- bind_rows(deadlift, squat, bench)

### viz warm up sets

viz_warm_up_sets <- warm_up_sets %>%
  ggplot(
    aes(
      x = set_num, 
      y = weight, 
      color = exercise, 
      size = reps)) +
  geom_point(alpha = 0.7) +
  geom_text(aes(
    label = round(weight, 1)), 
    vjust = 0, 
    hjust = 0, 
    size = 5,
    color = "black") +
  scale_size_manual(
    values = c("1" = 1, # Set manual size values for reps
               "2" = 3.5, 
               "3" = 7.5, 
               "5" = 15,
               "10" = 25)) +  
  labs(x = "Set", 
       y = "Weight (lbs)", 
       color = "Exercise", 
       size = "Reps") +
  ggtitle("Warm Up Sets for One Rep Max") +
  guides(size = guide_legend(title = "Reps"))  # Customize legend title

viz_warm_up_sets
