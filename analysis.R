#
#
#
#
#
# plot(gam.results.ind[[1]], pages = 1, all.terms = T)
#
#
# unique(gam.results.ind[[1]]$coefficients %>% names())
#
# d <- derivatives(gam.results.key[[1]])
# ? derivatives
# d1 <- derivatives(gam.results.ind[[1]], term = "year")
# ggplot(d, aes(x = data,))
#
# y = plot(gam.results.ind[[1]])
# draw(derivatives(gam.results.key[[92]]))
# ? draw.derivatives
#
# # These are the species for which we don't have analysis.
# ts = birds.grouped %>% filter(key == "House Finch") %>% distinct(year, key, .keep_all = T)
#
#
#
# # ARIMA MODELING -------------------------------------------------------
# # https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/
# # install.packages("fUnitRoots") # If you already have installed this package, you can omit this line
# library(fUnitRoots)
#
# # Follow those steps to try to automate the selection via visualization^^^
# x <- birds.grouped %>%
#     filter(ind == index[i])
# # filter(key == index[i])
#
# plot(x$value ~ x$year, type = "l")
# plot(log(x$value) ~ x$year, type = "l")
# # test for stationarity
# adfTest(diff(x$value), lags = 1)
# adfTest(diff(x$value), lags = 2)
# adfTest(diff(x$value), lags = 3)
#
# ? adfTest
