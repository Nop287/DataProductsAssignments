library(UsingR)
data(galton)

## Loading World Bank data for GDP of european countries
dat = WDI(indicator="NY.GDP.MKTP.CD", country=c("BE", "BG", "CZ", "DK", "DE", "EE", "IE", "GR", "ES", "FR", "HR", "IT", "CY", "LV", "LT", "LU", "HU", "MT", "NL", "AT", "PL", "PT", "RO", "SI", "SK", "FI", "SE", "GB"), start=1945, end=2015)
dat$country = factor(dat$country)
dat$iso2c = factor(dat$iso2c)

## Plotting the data
ggplot(dat, aes(year, NY.GDP.PCAP.KD, color=country)) + geom_line() + 
  xlab('Year') + ylab('GDP per capita')

shinyServer(
  function(input, output) {
    output$newHist <- renderPlot({
      hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
      mu <- input$mu
      lines(c(mu, mu), c(0, 200),col="red",lwd=5)
      mse <- mean((galton$child - mu)^2)
      text(63, 150, paste("mu = ", mu))
      text(63, 140, paste("MSE = ", round(mse, 2)))
    })
    
  }
)