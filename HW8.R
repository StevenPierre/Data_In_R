#clear environment
rm(list = ls())

set.seed(99)

install.packages('FrF2')
library(FrF2)

FrF2(16, 10)
