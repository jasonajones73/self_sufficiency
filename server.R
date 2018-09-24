require(shiny)
require(highcharter)
require(DT)
require(lubridate)

source("global.R")

function(input, output, session) {
  
  
# Filtering family standard
  fam_stand <- reactive({
    family_standard %>%
      filter(Adults == input$adults_sm &
               Infants == input$infants &
               Preschoolers == input$preschool &
               `School-Age` == input$school_age &
               Teenager == input$teenager) %>%
      select(6:19) %>%
      gather(key = "Category", value = "Amount", 1:ncol(.)) %>%
      mutate(Amount = abs(Amount))
  }) # family-standard-filtering
  
  output$test <- renderDT({datatable(fam_stand())})
  
  output$test2 <- renderHighchart({
    fam_stand() %>%
      filter(Category != "Annual" & Category != "Hourley") %>%
    hchart("column", hcaes(Category, Amount, fill = Category)) %>%
      hc_tooltip(valuePrefix = "$")
  })

  
# Monthly Gross Income ----
  monthly_gross <- reactive({
    round(((input$wage * input$hours) * 52) / 12, digits = 0)
  })
  
# Family Composition Data Filter ----
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
  
  output$family_compare_income <- renderHighchart({
    guil_sss %>%
      filter(type != "annual_wage" & type != "hourly_wage" & category != "expense") %>%
      left_join(data_frame(family = families, fam_name = names(families))) %>%
      left_join(data_frame(type = credits, type_name = names(credits))) %>%
      hchart("column", hcaes(x = fam_name, y = amount, group = type_name)) %>%
      hc_tooltip(valuePrefix = "$", split = TRUE) %>%
      hc_plotOptions(series = list(stacking = "normal"))
  })
  
  output$family_compare_expense <- renderHighchart({
    guil_sss %>%
      filter(category != "income") %>%
      left_join(data_frame(family = families, fam_name = names(families))) %>%
      left_join(data_frame(type = expenses, type_name = names(expenses))) %>%
      hchart("column", hcaes(x = fam_name, y = amount, group = type_name)) %>%
      hc_tooltip(valuePrefix = "$", split = TRUE) %>%
      hc_plotOptions(series = list(stacking = "normal"))
  })
  
  dat <- reactive({
    data_frame("Family Composition" = input$family,
               "Account Balance" = input$checking,
               "Monthly Wage" = round(((input$wage * input$hours) * 52) / 12, digits = 0),
               "Housing Voucher" = input$housing_voucher,
               "Childcare Subsidy" = input$childcare_subsidy,
               "SNAP" = input$snap,
               "WIC" = input$wic,
               "Healthcare Subsidy" = input$healthcare_subsidy) %>%
      .[rep(1, length.out = 12), ] %>%
      mutate(date = seq(from = Sys.Date(), to = (Sys.Date() %m+% months(11)), by = "1 month")) %>%
      gather(key = "category", value = "amount", 1:8)
  })
  
  output$plot <- renderHighchart({
    dat() %>%
      hchart("line", hcaes(date, as.integer(amount), group = category)) %>%
      hc_tooltip(valuePrefix = "$")
  })
  
} # server-function







