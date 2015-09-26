library(shiny)
library(ggplot2)
library(WDI)

# Loading World Bank data for GDP of european countries
dat = WDI(indicator="NY.GDP.MKTP.CD", country=c("BE", "BG", "CZ", "DK", "DE", "EE", "IE", "GR", "ES", "FR", "HR", "IT", "CY", "LV", "LT", "LU", "HU", "MT", "NL", "AT", "PL", "PT", "RO", "SI", "SK", "FI", "SE", "GB"), start=1945, end=2015)
# Convert the relevant fields to factor
dat$country = factor(dat$country)
dat$iso2c = factor(dat$iso2c)

# Define server logic required to draw a plot of yearly GDP
shinyServer(function(input, output) {
  
  # Expression that generates a plot of GDP. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot
  
  output$gdpPlot <- renderPlot({
    plotDat <- dat[dat$country %in% input$checkboxCountry, ]
    plotDat <- plotDat[plotDat$year >= input$sliderYear[1] & plotDat$year <= input$sliderYear[2], ]
    ggplot(plotDat, aes(year, NY.GDP.MKTP.CD, color=country)) + geom_line() + 
                xlab('Year') + ylab('GDP per capita')
  })
  
})