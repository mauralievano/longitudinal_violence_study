
library(tidyverse)

## Load data
load('../data/female_SCM.RData')

## Baseline covariates
W <- c(
  'race', 'sxorient', 'consent', 'forced', 'forced_att',
  'sex_bef14', 'suicide1', 'relation1', 'religion1', 'psywell1',
  'victfrnd1', 'drug1', 'alcohol1'
)
## Variables in time ordering:
T1 <- c(
  'victim1',
  'suicide2', 'relation2', 'religion2', 'psywell2',
  'victfrnd2', 'drug2', 'alcohol2'
)
T2 <- c(
  'victim2',
  'suicide3', 'relation3', 'religion3', 'psywell3',
  'victfrnd3', 'drug3', 'alcohol3'
)
T3 <- c(
  'victim3',
  'suicide4', 'relation4', 'religion4', 'psywell4',
  'victfrnd4', 'drug4', 'alcohol4'
)
T4 <- c('victim4', 'Y')

time_order <- c(
  W, T1, T2, T3, T4
)

## Add censoring nodes
female_SCM <- female_SCM %>%
  `[`(time_order)

compute_censoring <- function(t = 1) {
  sapply(
    1:nrow(female_SCM),
    function(row) {
      first_covar <- which(names(female_SCM) == paste0('victim', t))
      as.numeric(all(is.na(female_SCM[row, first_covar:ncol(female_SCM)])))
    }
  )
}

C1 <- compute_censoring(1)
C2 <- compute_censoring(2)
C3 <- compute_censoring(3)
C4 <- compute_censoring(4)

female_SCM <- cbind(
  female_SCM[, W], C1,
  female_SCM[, T1], C2,
  female_SCM[, T2], C3,
  female_SCM[, T3], C4,
  female_SCM[, T4]
)

save(female_SCM, file='../data/female_SCM_censoring.RData')
