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

## requires packages 'e1071' and 'ranger', 
SL.library <- c('SL.mean', 'SL.glm', 'SL.glmnet', 'SL.ranger')
attr(SL.library, 'return.fit') <- TRUE

ltmle <- function(...) suppressMessages(ltmle::ltmle(...))

## ~10-15 min to run
results_tmle <- ltmle(
  data = female_SCM,
  Anodes = c('victim1', 'victim2', 'victim3','victim4'),
  Cnodes = c('C1', 'C2', 'C3', 'C4'),
  Lnodes = Lnodes,
  Ynodes = 'Y',
  abar = list(
    c(1, 1, 1, 1),
    c(0, 0, 0, 0)
  ),
  SL.library = SL.library
)

save(results_tmle, file='results_tmle.Rdata')
load('results_tmle.Rdata')

summary(results_tmle, 'tmle')
summary(results_tmle, 'iptw')

## ~10-15 min to run
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
  SL.library = SL.library,
  gcomp = TRUE
)

save(results_gcomp, file='results_gcomp.Rdata')
load('results_gcomp.Rdata')

summary(results_gcomp)

## unadjusted

## < 1 min to run
results_unadj <- ltmle(
  female_SCM %>% select(
    C1, victim1, C2, victim2, C3, victim3, C4, victim4, Y
  ),
  Anodes = c('victim1', 'victim2', 'victim3','victim4'),
  Cnodes = c('C1', 'C2', 'C3', 'C4'),
  Ynodes = 'Y',
  abar = list(
    c(1, 1, 1, 1),
    c(0, 0, 0, 0)
  ),
  SL.library = SL.library
)

summary(results_unadj)
