# THIS NEEDS TO BE UDPATED
# CURRENTLY DOES NOT PRODUCE DATA THAT I ACTUALLY WANT

# Visual for predicted progress on compound lifts -----------------------------
#
# - Predicted working set progress for compound lifts based on one rep max.
# - Probably very unrealistic as it gets further along.
#
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here::here("scripts", "01_helper_load_data.R"))

# -----------------------------------------------------------------------------

# remove na values
max <- compound_1rm_weekly %>%
  na.omit()

# function to round to nearest multiple
# so that the weights are easier to work with
round_to_nearest_multiple <- function(num, multiple) {
  rounded_value <- round(num / multiple) * multiple
  return(rounded_value)
}

### get most recent day

# turn date col into character
# select date, day
schedule_days <- schedule %>%
  mutate(
    date = as.character(date)
  ) %>%
  select(
    date,
    day
  )

# get current date as character
current_date <- as.character(Sys.Date())

# get current day number
current_day <- schedule_days %>%
  filter(date == current_date) %>%
  select(day) %>%
  pull()

### create dfs for each lift's predicted progress (pp)

# bench

bench <- max %>% filter(
  exercise == "bench_press") %>%
  mutate(date_diff = abs(as.numeric(day - current_day))) %>%
  filter(date_diff == min(date_diff)) %>%
  slice(which.max(max_weight)) %>%
  select(-date_diff)

bench_pp <- data.frame(
  exercise = "bench_press",
  week = seq(bench$week, by = 1, length.out = 52),
  weight = seq(
    round_to_nearest_multiple(
      bench$max_weight * 0.7, 
      5), 
    by = 2.5, 
    length.out = 52)
)

# squat

squat <- max %>% filter(
  exercise == "squat_barbell") %>%
  mutate(date_diff = abs(as.numeric(day - current_day))) %>%
  filter(date_diff == min(date_diff)) %>%
  slice(which.max(max_weight)) %>%
  select(-date_diff)

squat_pp <- data.frame(
  exercise = "squat_barbell",
  week = seq(squat$week, by = 1, length.out = 52),
  weight = seq(
    round_to_nearest_multiple(
      squat$max_weight * 0.7, 
      5), 
    by = 5, 
    length.out = 52)
)

# deadlift

deadlift <- max %>% filter(
  exercise == "deadlift") %>%
  mutate(date_diff = abs(as.numeric(day - current_day))) %>%
  filter(date_diff == min(date_diff)) %>%
  slice(which.max(max_weight)) %>%
  select(-date_diff)

deadlift_pp <- data.frame(
  exercise = "deadlift",
  week = seq(deadlift$week, by = 1, length.out = 52),
  weight = seq(
    round_to_nearest_multiple(
      deadlift$max_weight * 0.7, 
      5), 
    by = 5, 
    length.out = 52)
)

### combine dfs
predicted_progress <- bind_rows(bench_pp, squat_pp, deadlift_pp)

# viz for predicted progress
viz_pp <- predicted_progress %>%
  ggplot(aes(
    x = week,
    y = weight,
    color = exercise
  )) +
  geom_line() +
  geom_point()

viz_pp
