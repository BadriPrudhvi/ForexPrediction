library(quantmod)
library(prophet)
library(dplyr)
library(lubridate)
library(ggplot2)
library(plotly)

getFX("USD/INR",from="2012-04-01")

exrates <- as.data.frame(USDINR)
exrates$Date <-rownames(exrates)
rownames(exrates) <- NULL
exrates <- exrates %>%
  mutate(Date = as.Date(Date)) %>%
  select(ds = Date, y = USD.INR)

m <- prophet(exrates)

future <- make_future_dataframe(m, periods = 60)
forecast <- prophet:::predict.prophet(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])
ggplotly(plot(m, forecast))
prophet_plot_components(m, forecast)
