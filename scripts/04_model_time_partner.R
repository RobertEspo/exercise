# Time spent versus partner-----------------------------------------------------
#
# - See who I spend the most time with at the gym
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here("scripts","01_helper_load_data.R"))

# -----------------------------------------------------------------------------

# load time spent at gym data 
time_partner <- time %>%
  na.omit() %>%
  # change partner ID codes to names
  left_join(partner_key, by = c("partner_id" = "partner_id")
  ) %>%
  transmute(
    total_time = total_time,
    partner = factor(partner)
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
