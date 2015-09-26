library(shiny)

# Define UI for application that draws a plot of GDP from World Bank data
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Yearly GDP of European Countries (US$)"),
  
  # Sidebar with a slider input for year from/to and 
  # a checkbox group for country
  sidebarLayout(
    sidebarPanel(
      # Slider for the year from/to
      sliderInput("sliderYear", label = h3("Year from/to"), min = min(dat$year), 
                  max = max(dat$year), sep = "", value = c(min(dat$year), max(dat$year))),
      # checkbox group for country
      checkboxGroupInput("checkboxCountry", "Choose a country:", 
                         choices = levels(dat$country), selected = "Germany"
      )
    ),
    
    # Show the plot
    mainPanel(
      plotOutput("gdpPlot")
    )
  )
))