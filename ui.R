require(shiny)
require(shinythemes)
require(tidyverse)

expenses = filter(guil_sss, category == "expense")


navbarPage(title = "Self Sufficiency Prototype", collapsible = TRUE,
           fluid = TRUE, theme = shinytheme(theme = "darkly"),
           
           fluidRow(
             column(width = 6,
                    selectizeInput(inputId = "family", label = "Please select your family composition", choices = names(families),
                                   multiple = FALSE, width = "100%", options = list(placeholder="Hover or start typing here...",
                                                                                    selectOnTab=TRUE,
                                                                                    openOnFocus=TRUE,
                                                                                    hideSelected=TRUE)) #families-input
                    ),#row 1-column 1
             column(width = 6,
                    selectizeInput(inputId = "expenses", label = NULL, choices = unique(expenses$type),
                                   multiple=TRUE, width="100%", options = list(placeholder="Start typing to select some expenses...",
                                                                               selectOnTab=TRUE,
                                                                               openOnFocus=TRUE,
                                                                               hideSelected=TRUE)) #expense-input
                    ) #row 1-column 2
             )#row 1
           ) #page