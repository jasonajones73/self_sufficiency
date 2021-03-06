require(tidyverse)
require(highcharter)

lang <- getOption("highcharter.lang")
lang$thousandsSep <- ","
options(highcharter.lang = lang)

guil_sss = read_csv("data/guil_sss_update.csv")

large_family_standard = read_csv("data/large_family_standard_clean.csv")

family_standard = read_csv("data/family_standard_clean.csv")

# Creating choices for family composition selection
families = c("Adult" = 1,
             "Adult and Preschooler" = 2,
             "Adult, Infant, and Preschooler" = 3,
             "Adult, Preschooler, and School-Age" = 4,
             "Adult, School-Age, and Teenager" = 5,
             "Adult, Infant, Preschooler, and School-Age" = 6,
             "2 Adults, Infant, and Preschooler" = 7,
             "2 Adults, Preschooler, and School-Age" = 8)

# Creating choices for expense category selections
expense_filt = filter(guil_sss, category == "expense")

expenses = setNames(c(unique(expense_filt$type)),
                    c("Child Care",
                      "Food",
                      "Health Care",
                      "Housing",
                      "Miscellaneous",
                      "Monthly Savings Contribution",
                      "Taxes",
                      "Transportation"))

# Creating choices for credit category selections
credits = c("Child Care Tax Credit" = "child_care_tax_credit",
            "Child Tax Credit" = "child_tax_credit",
            "Earned Income Tax Credit" = "earned_income_tax_credit",
            "Monthly Salary" = "mon_wage")


define = data_frame("Monthly Wage" = "Income",
                    "Housing Voucher" = "Benefit",
                    "Childcare Subsidy" = "Benefit",
                    "SNAP" = "Benefit",
                    "WIC" = "Benefit",
                    "Healthcare Subsidy" = "Benefit") %>%
  gather(key = "category", value = "Breakdown")





### Optional inputs
# Medicaid








