#  1RM for all exercises ------------------------------------------------------
#
# - Generate 1RM for all exercises
# - Generate warm-up sets for 1RM attempt
#
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here::here("scripts", "01_helper_load_data.R"))

# -----------------------------------------------------------------------------

# function to round to nearest multiple
# so that the weights are easier to work with
round_to_nearest_multiple <- function(num, multiple) {
  rounded_value <- round(num / multiple) * multiple
  return(rounded_value)
}

# generate predicted one rep max for all exercises

one_rep_max_all <- routine %>%
  # omit NA values
  na.omit() %>%
  # select exercise, set number, weight, reps completed
  transmute(
    muscle_group,
    exercise,
    weight,
    reps_completed,
    gym_day_count,
  ) %>%
  # filter for compound lifts
  filter(
    # muscle_group == ("back"),
    # filter to make sure no failed attempts are included
    reps_completed > 0,
    weight > 0
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
  # get weighted average for max of each set of each exercise
  group_by(exercise, muscle_group) %>%
  summarize(one_rep_max_average = weighted.mean(one_rep_max, w = stat_weights)) %>%
  arrange(muscle_group) %>%
  # add col set, 5 sets for each exercise
  uncount(weights = 5) %>%
  mutate(set = rep(1:5, length.out = n())) %>%
  # add weight to do for each set based on predicted 1RM
  mutate(
    weight = case_when(
      set == 1 ~ 0.5 * one_rep_max_average,
      set == 2 ~ 0.6 * one_rep_max_average,
      set == 3 ~ 0.75 * one_rep_max_average,
      set == 4 ~ 0.85 * one_rep_max_average,
      set == 5 ~ one_rep_max_average
    )
  ) %>%
  # remove one rep max average col
  select(
    -one_rep_max_average
  ) %>%
  # round weights to nearest multiple of 5
  mutate(
    weight = round_to_nearest_multiple(weight, 5)
    )

# create dfs for each muscle group
muscle_group_dfs <- split(one_rep_max_all, one_rep_max_all$muscle_group)

for (muscle_group_name in names(muscle_group_dfs)) {
  assign(muscle_group_name, muscle_group_dfs[[muscle_group_name]])
}