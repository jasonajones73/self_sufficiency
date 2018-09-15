

require(tidyverse)

guil_sss = read_csv("data/guil_sss_update.csv")


families = c("Adult" = 1,
             "Adult and Preschooler" = 2,
             "Adult, Infant, and Preschooler" = 3,
             "Adult, Preschooler, and School-Age" = 4,
             "Adult, School-Age, and Teenager" = 5,
             "Adult, Infant, Preschooler, and School-Age" = 6,
             "2 Adults, Infant, and Preschooler" = 7,
             "2 Adults, Preschooler, and School-Age" = 8)



