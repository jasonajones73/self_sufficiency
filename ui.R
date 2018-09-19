require(shiny)
require(shinythemes)
require(tidyverse)
require(highcharter)
require(DT)

navbarPage(
  title = "Self Sufficiency Prototype", collapsible = TRUE,
  fluid = TRUE, theme = shinytheme(theme = "yeti"),
  
  tabPanel(
    title = "Simulation", icon = icon(name = "calculator", class = "fa-2x", lib = "font-awesome"),
    sidebarLayout(
      sidebarPanel(
        selectizeInput(
          inputId = "family", label = "Select your family composition:", choices = families,
          multiple = FALSE, width = "100%", options = list(selectOnTab = TRUE,
                                                           openOnFocus = TRUE,
                                                           hideSelected = TRUE)
        ), # families-input
        selectizeInput(
          inputId = "expenses", label = "Select applicable expenses:", choices = expenses,
          multiple = TRUE, width = "100%", options = list(placeholder = "Hover or start typing to select some expenses...",
                                                          selectOnTab = TRUE,
                                                          openOnFocus = TRUE,
                                                          hideSelected = TRUE)
        ), # expense-input
        selectizeInput(
          inputId = "credits", label = "Select applicable credits:", choices = credits[1:3],
          multiple = TRUE, width = "100%", options = list(placeholder = "Hover or start typing to select some credits...",
                                                          selectOnTab = TRUE,
                                                          openOnFocus = TRUE,
                                                          hideSelected = TRUE)
        ), # credits-input
        numericInput(
          inputId = "checking", label = "Checking account balance:", value = 0
        ), # checking-balance-input
        numericInput(
          inputId = "wage", label = "Hourly Wage:", value = 7.00, step = 0.01
        ), # wage-numeric-input
        sliderInput(
          inputId = "hours", label = "Weekly Hours:", min = 0, max = 40,
          value = 20, step = 1
        ), # hours-input
        sliderInput(
          inputId = "housing_voucher", label = "Housing Voucher Amount:", min = 0, max = 4000,
          value = 0, step = 10, sep = ",", pre = "$"
        ), # housing-voucher-slider-input
        sliderInput(
          inputId = "childcare_subsidy", label = "Childcare Subsidy Amount:", min = 0, max = 4000,
          value = 0, step = 10, sep = ",", pre = "$"
        ), #childcare-subsidy-slider-input
        sliderInput(
          inputId = "snap", label = "SNAP Amount:", min = 0, max = 4000,
          value = 0, step = 10, sep = ",", pre = "$"
        ), #snap-slider-input
        sliderInput(
          inputId = "wic", label = "WIC Amount:", min = 0, max = 4000,
          value = 0, step = 10, sep = ",", pre = "$"
        ), #wic-slider-input
        sliderInput(
          inputId = "healthcare_subsidy", label = "Healthcare Subsidy Amount:", min = 0, max = 4000,
          value = 0, step = 10, sep = ",", pre = "$"
        ), #healthcare-subsidy-slider-input
        sliderInput(
          inputId = "child_support", label = "Child Support Amount:", min = 0, max = 4000,
          value = 0, step = 10, sep = ",", pre = "$"
        ) #child-support-slider-input
      ), # sidebarPanel
      
      mainPanel(highchartOutput("comparison"),
                highchartOutput("plot")) # mainPanel
      
    ) # sidebar-layout
  ), # tab-panel
  
  tabPanel(title = "Comparison", icon = icon("pie-chart", class = "fa-2x"),
    sidebarLayout(
      sidebarPanel(), # sidebar-panel
      mainPanel(highchartOutput("family_compare_income"),
                highchartOutput("family_compare_expense")) # main-panel
    ) # side-bar-layout
  ) # tab-panel
) # page
