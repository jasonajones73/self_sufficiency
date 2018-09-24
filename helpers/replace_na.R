

require(tidyverse)

dat <- read_csv("data/family_standard.csv")


dat$Infants[is.na(dat$Infants)] <- 0
dat$Preschoolers[is.na(dat$Preschoolers)] <- 0
dat$`School-Age`[is.na(dat$`School-Age`)] <- 0
dat$Teenager[is.na(dat$Teenager)] <- 0


write_csv(dat, "data/family_standard_clean.csv", append = FALSE, na = "")


dat <- read_csv("data/large_family_standard.csv")


dat$Adults[is.na(dat$Adults)]
dat$Children[is.na(dat$Children)] <- 0


write_csv(dat, "data/large_family_standard_clean.csv", append = FALSE, na = "")
