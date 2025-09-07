library(shiny)
library(TidyDensity)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Zero-Inflated Poisson Simulation with tidydensity"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("pi", "Zero Inflation Probability (π):", 
                  min = 0, max = 1, value = 0.3, step = 0.01),
      numericInput("lambda", "Poisson Mean (λ):", 
                   value = 2, min = 0.1, step = 0.1),
      numericInput("n", "Sample Size:", 
                   value = 1000, min = 100, step = 100)
    ),
    
    mainPanel(
      plotOutput("histPlot"),
      verbatimTextOutput("summaryStats")
    )
  )
)

server <- function(input, output) {
  
  sim_data <- reactive({
    # Simulate ZIP data manually since tidydensity doesn't have ZIP built-in
    set.seed(123)
    is_zero <- rbinom(input$n, 1, input$pi)
    y <- ifelse(is_zero == 1, 0, rpois(input$n, input$lambda))
    tibble(value = y)
  })
  
  output$histPlot <- renderPlot({
    ggplot(sim_data(), aes(x = value)) +
      geom_histogram(binwidth = 1, fill = "#2c7fb8", color = "white") +
      labs(title = "Histogram of Simulated ZIP Data",
           x = "Value", y = "Frequency") +
      theme_minimal()
  })
  
  output$summaryStats <- renderPrint({
    data <- sim_data()
    mean_val <- mean(data$value)
    var_val <- var(data$value)
    cat("Mean:", round(mean_val, 3), "\n")
    cat("Variance:", round(var_val, 3), "\n")
  })
}

shinyApp(ui = ui, server = server)
