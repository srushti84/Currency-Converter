# Load necessary libraries
library(shiny)

# Define static exchange rates
# Here, 1 unit of each currency is defined in terms of USD
exchange_rates <- list(
  USD = 1,        # Base currency
  EUR = 0.85,     # 1 USD = 0.85 EUR
  GBP = 0.75,     # 1 USD = 0.75 GBP
  INR = 74.5      # 1 USD = 74.5 INR
)

# Define the UI
ui <- fluidPage(
  
  # App title
  titlePanel("Currency Converter"),
  
  sidebarLayout(
    sidebarPanel(
      # Dropdowns for selecting currencies
      selectInput("from_currency", "From Currency", choices = names(exchange_rates)),
      selectInput("to_currency", "To Currency", choices = names(exchange_rates)),
      
      # Input field for amount
      numericInput("amount", "Amount", value = 1, min = 0, step = 0.01),
      
      # Convert button
      actionButton("convert", "Convert")
    ),
    
    # Display conversion result
    mainPanel(
      textOutput("result")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  # Observe the Convert button event
  observeEvent(input$convert, {
    
    # Retrieve exchange rates for the selected currencies
    from_rate <- exchange_rates[[input$from_currency]]
    to_rate <- exchange_rates[[input$to_currency]]
    
    # Convert the amount
    converted_amount <- input$amount * (to_rate / from_rate)
    
    # Display the result
    output$result <- renderText({
      paste(input$amount, input$from_currency, "=", round(converted_amount, 2), input$to_currency)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
