
library(tidyverse)
library(ggpubr)

load('results_tmle.Rdata')
source('../src/utility.R')

prop_scores1 <- data.frame(
  A1 = results_tmle$fit$g[[1]]$victim1$SL.predict
)

prop_scores2 <- data.frame(
  A2 = results_tmle$fit$g[[1]]$victim2$SL.predict,
  C2 = results_tmle$fit$g[[1]]$C2$SL.predict
)

prop_scores3 <- data.frame(
  A3 = results_tmle$fit$g[[1]]$victim3$SL.predict,
  C3 = results_tmle$fit$g[[1]]$C3$SL.predict
)

prop_scores4 <- data.frame(
  A4 = results_tmle$fit$g[[1]]$victim4$SL.predict,
  C4 = results_tmle$fit$g[[1]]$C4$SL.predict
)

A1 <- ggplot(prop_scores1) +
  geom_density(aes(x = A1)) +
  theme_nice
C1 <- ggplot() +
  geom_text(aes(C1, y, label = text),
            data = data.frame(C1 = .5, y = 0.5, text = "NA"),
            size=10) +
  theme_nice

A2 <- ggplot(prop_scores2) +
  geom_density(aes(x = A2)) +
  theme_nice
C2 <- ggplot(prop_scores2) +
  geom_density(aes(x = C2)) +
  theme_nice

A3 <- ggplot(prop_scores3) +
  geom_density(aes(x = A3)) +
  theme_nice
C3 <- ggplot(prop_scores3) +
  geom_density(aes(x = C3)) +
  theme_nice

A4 <- ggplot(prop_scores4) +
  geom_density(aes(x = A4)) +
  theme_nice
C4 <- ggplot(prop_scores4) +
  geom_density(aes(x = C4)) +
  theme_nice

prop_score_plot <- ggarrange(
  A1, A2, A3, A4,
  C1, C2, C3, C4,
  nrow = 2, ncol = 4
)

ggsave(
  '../figure/dist-prop-scores.png', prop_score_plot, device='png',
  width=15, height=8
)
