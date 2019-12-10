library(tidyverse)
library(ltmle)

## Load data
load('../data/female_SCM_imputed.RData')

female_SCM <- female_SCM %>%
  mutate(
    victim1 = as.numeric(victim1),
    victim2 = as.numeric(victim2),
    victim3 = as.numeric(victim3),
    victim4 = as.numeric(victim4),
    C1 = BinaryToCensoring(is.censored = C1),
    C2 = BinaryToCensoring(is.censored = C2),
    C3 = BinaryToCensoring(is.censored = C3),
    C4 = BinaryToCensoring(is.censored = C4)
  )

Lnodes <- c(
  'suicide2', 'relation2', 'religion2', 'psywell2',
  'victfrnd2', 'drug2', 'alcohol2',
  'suicide3', 'relation3', 'religion3', 'psywell3',
  'victfrnd3', 'drug3', 'alcohol3',
  'suicide4', 'relation4', 'religion4', 'psywell4',
  'victfrnd4', 'drug4', 'alcohol4'
)

ltmle <- function(...) suppressMessages(ltmle::ltmle(...))

results_tmle <- ltmle(
  data = female_SCM,
  Anodes = c('victim1', 'victim2', 'victim3','victim4'),
  Cnodes = c('C1', 'C2', 'C3', 'C4'),
  Lnodes = Lnodes,
  Ynodes = 'Y',
  abar = list(
    c(1, 1, 1, 1),
    c(0, 0, 0, 0)
  )
)

summary(results_tmle, 'tmle')
summary(results_tmle, 'iptw')

results_gcomp <- ltmle(
  data = female_SCM,
  Anodes = c('victim1', 'victim2', 'victim3','victim4'),
  Cnodes = c('C1', 'C2', 'C3', 'C4'),
  Lnodes = Lnodes,
  Ynodes = 'Y',
  abar = list(
    c(1, 1, 1, 1),
    c(0, 0, 0, 0)
  ),
  gcomp = TRUE
)

summary(results_gcomp)
