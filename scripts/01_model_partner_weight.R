# Amount of weight based on partner --------------------------------------------
#
# - Model the relationship between the weight 
# - per set and who I exercise with
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "00_libs.R"))

# -----------------------------------------------------------------------------

# load csv
routine <- range_read('1H8w_d53ZHczs8-gAtDsIfAlJnH07GHnZUi0Leh_dyOQ') %>%
  # center and standardize weight
  # factor partner column
  transmute(
    scaled_weights = as.vector(scale(weight)),
    partner = factor(partner)
  )
  
# frequentist model
fit_f <- lm(scaled_weights ~ partner, data = routine)
summary(fit_f)

# bayesian model
fit_b <- brm(scaled_weights ~ partner, data = routine, family = gaussian())
summary(fit_b)
plot(fit_b)

# forest plot

# turn model output into tibble
as_tibble(fit_b) %>%
  # get only the effects (i.e. ignoring sigma, intercept, etc.)
  select("b_Intercept", starts_with("b_partner")) %>%
  # change names of groups so they make sense
  transmute(
    alone = b_Intercept,
    cristian = b_Intercept + b_partner1,
    jordan = b_Intercept + b_partner2,
    jon = b_Intercept + b_partner3,
    jon_and_jordan = b_Intercept + b_partner4
  ) %>%
  # pivot_longer() so ggplot can read it
  pivot_longer(everything(), names_to = "partner", values_to = "estimate") %>%
  ggplot(., aes(x = estimate, y = partner)) + 
  # stat_halfeye() plots distribution, pch = shape
  stat_halfeye(slab_fill = '#cc0033', pch=21, point_fill = "white") +
  # defaults to left, but scale_y_discrete() can specify it to be rightsided
  # scale_y_discrete(position = "right") +
  labs(y = "partner", x = "estimate")