# Time spent versus partner-----------------------------------------------------
#
# - See who I spend the most time with at the gym
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_libs.R"))

# -----------------------------------------------------------------------------

# load time spent at gym data 
time <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ', sheet = "time") %>%
  na.omit() %>%
  select(
    total_time,
    date
  )

# load partner data
# select date, partner cols
partner <- routine %>%
  select(
    date,
    partner
  ) %>%
  distinct(date, .keep_all = TRUE) %>%
  transmute(
    partner = ifelse(partner == 0, "alone",
                     ifelse(partner == 1, "Cristian",
                            ifelse(partner == 2, "Jordan",
                                   ifelse(partner == 3, "Jon",
                                          ifelse(partner == 4, "Jon_and_Jordan",
                                                 ifelse(partner == 5, "Jon_and_Luis",
                                                        ifelse(partner == 6, "Luis", NA))))))),
    date
  )

# join dfs by date column & factor partner col
time_partner <- left_join(time, partner, by = "date") %>%
  transmute(
    partner = factor(partner),
    total_time = as.character(total_time)
  )

# convert hh:mm to mm
time_split <- strsplit(time_partner$total_time, ":")
hours <- as.integer(sapply(time_split, function(x) x[1]))
minutes <- as.integer(sapply(time_split, function(x) x[2]))

# add to df
time_partner$time_mins <- hours * 60 + minutes

# frequentist model total_time ~ partner
fit_f <- lm(time_mins ~ partner, data = time_partner)

summary(fit_f)

# bayesian model
fit_b <- brm(time_mins ~ partner, data = time_partner, family = gaussian)
summary(fit_b)

# forest plot

# turn model output into tibble
as_tibble(fit_b) %>%
  # get only the effects (i.e. ignoring sigma, intercept, etc.)
  select("b_Intercept", starts_with("b_partner")) %>%
  # change names of groups so they make sense
  transmute(
    alone = b_Intercept,
    cristian = b_Intercept + b_partnerCristian,
    jon = b_Intercept + b_partnerJon,
    jordan = b_Intercept + b_partnerJordan,
    jon_and_luis = b_Intercept + b_partnerJon_and_Luis,
    luis = b_Intercept + b_partnerLuis
  ) %>%
  # pivot_longer() so ggplot can read it
  pivot_longer(everything(), names_to = "partner", values_to = "estimate") %>%
  ggplot(., aes(x = estimate, y = partner)) + 
  # stat_halfeye() plots distribution, pch = shape
  stat_halfeye(slab_fill = '#cc0033', pch=21, point_fill = "white") +
  # defaults to left, but scale_y_discrete() can specify it to be rightsided
  # scale_y_discrete(position = "right") +
  labs(y = "partner", x = "estimate")
