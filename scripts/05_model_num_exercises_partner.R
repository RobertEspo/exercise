### WARNING
### THIS SCRIPT SEES WHO I DO THE MOST SETS WITH
### NOT THE MOST EXERCISES

# num exercises versus partner--------------------------------------------------
#
# - See who I do the most exercises with
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_helper_libs.R"))
source(here("scripts","01_helper_load_data.R"))

# -----------------------------------------------------------------------------

# select day, partner cols
# rename partner col from codes to names
partners_exercises <- routine %>%
  na.omit() %>%
  select(
    day,
    partner_id,
    exercise
  ) %>%
  # change partner ID codes to names
  left_join(partner_key, by = c("partner_id" = "partner_id")
  ) %>%
  transmute(
    # remember that col name "partner" comes from df "partner_key"
    partner = factor(partner),
    day = factor(day),
    exercise
  ) %>%
  group_by(partner,day) %>%
  summarize(num_exercises = n_distinct(exercise))

# frequentist model num_sets ~ partner
fit_f <- glm(num_exercises ~ partner, 
             data = partners_exercises, family = poisson)
summary(fit_f)

# bayesian model
fit_b <- brm(num_exercises ~ partner, 
             data = partners_exercises, family = poisson)
summary(fit_b)

# forest plot

# turn model output into tibble
as_tibble(fit_b) %>%
  # get only the effects (i.e. ignoring sigma, intercept, etc.)
  select("b_Intercept", starts_with("b_partner")) %>%
  # change names of groups so they make sense
  transmute(
    alone = exp(b_Intercept),
    cristian = exp(b_Intercept + b_partnerCristian),
    jon = exp(b_Intercept + b_partnerJon),
    jon_and_jordan = exp(b_Intercept + b_partnerJon_and_Jordan),
    jordan = exp(b_Intercept + b_partnerJordan),
    jon_and_luis = exp(b_Intercept + b_partnerJon_and_Luis)
  ) %>%
  # pivot_longer() so ggplot can read it
  pivot_longer(everything(), names_to = "partner", values_to = "estimate") %>%
  ggplot(., aes(x = estimate, y = partner)) + 
  # stat_halfeye() plots distribution, pch = shape
  stat_halfeye(slab_fill = '#cc0033', pch=21, point_fill = "white") +
  # defaults to left, but scale_y_discrete() can specify it to be rightsided
  # scale_y_discrete(position = "right") +
  labs(y = "partner", x = "estimate")