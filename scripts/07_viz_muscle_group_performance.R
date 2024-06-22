# Muscle group performance viz -------------------------------------------------
#
# - Visualize progress for exercises by muscle group
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here("scripts","01_helper_load_data.R"))

# -----------------------------------------------------------------------------

# load data with relevant cols
muscle_groups <- routine %>%
  transmute(
    muscle_group,
    exercise = factor(exercise),
    set_number = factor(set_number),
    weight,
    date
  )

# create dfs for each muscle group
muscle_group_dfs <- split(muscle_groups, muscle_groups$muscle_group)

for (muscle_group_name in names(muscle_group_dfs)) {
  assign(muscle_group_name, muscle_group_dfs[[muscle_group_name]])
}

### CHEST ###

# find first point for each exercise
# to label them on the graph with name
first_points_chest <- chest %>%
  transmute(
    exercise,
    set_number = as.numeric(set_number),
    date,
    weight
  ) %>%
  group_by(exercise) %>%
  slice_min(date) %>%
  filter(set_number == min(set_number))

# chest exercise performance
chest_viz <- chest %>%
  ggplot(
    aes(
      x = date, 
      y = weight, 
      color = exercise, 
      group = interaction(exercise, set_number),
      )
  ) +
  geom_point(size = 3,
             alpha = 0.4) +
  geom_line() +
  geom_text_repel(data = first_points_chest,
                  aes(label = exercise),
                  box.padding = 0.5,
                  point.padding = 0.1,
                  size = 3,
                  color = "black") +
  labs(title = "Chest Exercise Performance",
       y = "Weight (lbs)")

chest_viz

### TRICEPS ### 

# find first point for each exercise
# to label them on the graph with name
first_points_triceps <- triceps %>%
  transmute(
    exercise,
    set_number = as.numeric(set_number),
    date,
    weight
  ) %>%
  group_by(exercise) %>%
  slice_min(date) %>%
  filter(set_number == min(set_number))

# triceps exercise performance viz
triceps_viz <- triceps %>%
  ggplot(
    aes(
      x = date, 
      y = weight, 
      color = exercise, 
      group = interaction(exercise, set_number),
    )
  ) +
  geom_point(size = 3,
             alpha = 0.4) +
  geom_line() +
  geom_text_repel(data = first_points_triceps,
                  aes(label = exercise),
                  box.padding = 0.5,
                  point.padding = 0.1,
                  size = 3,
                  color = "black") +
  labs(title = "Triceps Exercise Performance",
       y = "Weight (lbs)")

### BACK ###

# find first point for each exercise
# to label them on the graph with name
first_points_back <- back %>%
  transmute(
    exercise,
    set_number = as.numeric(set_number),
    date,
    weight
  ) %>%
  group_by(exercise) %>%
  slice_min(date) %>%
  filter(set_number == min(set_number))

# back exercise performance viz
back_viz <- back %>%
  ggplot(
    aes(
      x = date, 
      y = weight, 
      color = exercise, 
      group = interaction(exercise, set_number),
    )
  ) +
  geom_point(size = 3,
             alpha = 0.4) +
  geom_line() +
  geom_text_repel(data = first_points_back,
                  aes(label = exercise),
                  box.padding = 0.5,
                  point.padding = 0.1,
                  size = 3,
                  color = "black") +
  labs(title = "Back Exercise Performance",
       y = "Weight (lbs)")

### BICEPS ###

# find first point for each exercise
# to label them on the graph with name
first_points_biceps <- biceps %>%
  transmute(
    exercise,
    set_number = as.numeric(set_number),
    date,
    weight
  ) %>%
  group_by(exercise) %>%
  slice_min(date) %>%
  filter(set_number == min(set_number))

# biceps exercise performance viz
biceps_viz <- biceps %>%
  ggplot(
    aes(
      x = date, 
      y = weight, 
      color = exercise, 
      group = interaction(exercise, set_number),
    )
  ) +
  geom_point(size = 3,
             alpha = 0.4) +
  geom_line() +
  geom_text_repel(data = first_points_biceps,
                  aes(label = exercise),
                  box.padding = 0.5,
                  point.padding = 0.1,
                  size = 3,
                  color = "black") +
  labs(title = "Biceps Exercise Performance",
       y = "Weight (lbs)")

### ABDOMINALS ###

# find first point for each exercise
# to label them on the graph with name
first_points_abdominals <- abdominals %>%
  transmute(
    exercise,
    set_number = as.numeric(set_number),
    date,
    weight
  ) %>%
  group_by(exercise) %>%
  slice_min(date) %>%
  filter(set_number == min(set_number))

# back exercise performance viz
abdominals_viz <- abdominals %>%
  ggplot(
    aes(
      x = date, 
      y = weight, 
      color = exercise, 
      group = interaction(exercise, set_number),
    )
  ) +
  geom_point(size = 3,
             alpha = 0.4) +
  geom_line() +
  geom_text_repel(data = first_points_abdominals,
                  aes(label = exercise),
                  box.padding = 0.5,
                  point.padding = 0.1,
                  size = 3,
                  color = "black") +
  labs(title = "Abdominals Exercise Performance",
       y = "Weight (lbs)")

### LEGS ###

# find first point for each exercise
# to label them on the graph with name
first_points_legs <- legs %>%
  transmute(
    exercise,
    set_number = as.numeric(set_number),
    date,
    weight
  ) %>%
  group_by(exercise) %>%
  slice_min(date) %>%
  filter(set_number == min(set_number))

# back exercise performance viz
legs_viz <- legs %>%
  ggplot(
    aes(
      x = date, 
      y = weight, 
      color = exercise, 
      group = interaction(exercise, set_number),
    )
  ) +
  geom_point(size = 3,
             alpha = 0.4) +
  geom_line() +
  geom_text_repel(data = first_points_legs,
                  aes(label = exercise),
                  box.padding = 0.5,
                  point.padding = 0.1,
                  size = 3,
                  color = "black") +
  labs(title = "Legs Exercise Performance",
       y = "Weight (lbs)")

### SHOULDERS ###

# find first point for each exercise
# to label them on the graph with name
first_points_shoulders <- shoulders %>%
  transmute(
    exercise,
    set_number = as.numeric(set_number),
    date,
    weight
  ) %>%
  group_by(exercise) %>%
  slice_min(date) %>%
  filter(set_number == min(set_number))

# shoulders exercise performance viz
shoulders_viz <- shoulders %>%
  ggplot(
    aes(
      x = date, 
      y = weight, 
      color = exercise, 
      group = interaction(exercise, set_number),
    )
  ) +
  geom_point(size = 3,
             alpha = 0.4) +
  geom_line() +
  geom_text_repel(data = first_points_shoulders,
                  aes(label = exercise),
                  box.padding = 0.5,
                  point.padding = 0.1,
                  size = 3,
                  color = "black") +
  labs(title = "Shoulders Exercise Performance",
       y = "Weight (lbs)")

### FOREARMS ###

# find first point for each exercise
# to label them on the graph with name
first_points_forearms <- forearms %>%
  transmute(
    exercise,
    set_number = as.numeric(set_number),
    date,
    weight
  ) %>%
  group_by(exercise) %>%
  slice_min(date) %>%
  filter(set_number == min(set_number))

# forearms exercise performance viz
forearms_viz <- forearms %>%
  ggplot(
    aes(
      x = date, 
      y = weight, 
      color = exercise, 
      group = interaction(exercise, set_number),
    )
  ) +
  geom_point(size = 3,
             alpha = 0.4) +
  geom_line() +
  geom_text_repel(data = first_points_forearms,
                  aes(label = exercise),
                  box.padding = 0.5,
                  point.padding = 0.1,
                  size = 3,
                  color = "black") +
  labs(title = "Forearms Exercise Performance",
       y = "Weight (lbs)")