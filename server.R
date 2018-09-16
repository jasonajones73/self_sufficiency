require(shiny)
require(highcharter)

source("global.R")

function(input, output, session) {
  
  # Creating monthly gross income calculation
  monthly_gross <- reactive({
    round(((input$wage * input$hours) * 52) / 12, digits = 0)
  })
  
  # Filtering original data by family composition input
  guil_sss_filt <- reactive({
    guil_sss %>%
      filter(family == input$family)
  })
  
  # Creating comparison dataframe for comparison chart
  comparison <- reactive({
    data_frame("amount" = c(filter(guil_sss_filt(), type == "mon_wage")$amount[[1]],
                            monthly_gross(),
                            input$housing_voucher,
                            input$snap,
                            input$wic,
                            input$healthcare_subsidy,
                            input$child_support,
                            input$childcare_subsidy),
               "category" = c("Standard", rep("Personal", 7)),
               "type" = c("Income", "Income", "Housing Voucher", "SNAP", "WIC", "Healthcare Subsidy", "Child Support", "Childcare Subsidy")
    )
  })
  
  # Creating comparison chart
  output$comparison <- renderHighchart({
    hchart(comparison(), "column", hcaes(category, amount, group = type)) %>%
      hc_plotOptions(series = list(stacking = "normal"))
  })
  
}