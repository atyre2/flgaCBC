# Add groups to the bird data
birds.grouped <- full_join(birds, birds.new %>% rename(key = values) %>%  na.omit(family)) %>%
    distinct()

# # Maybe ditching?
# # Run the gams in all the groups (saves figs to file and exports a list of results)
# gams.groups <- runGams(df = birds.grouped, group.var = "ind", year.start = 1973,
#
#                                               zero.thresh = 0.50, lr.alpha = 0.05, ll.thresh = 1.4,
#                        mod.sel.ind = "human")
#
# # Run the gams in all the species (saves figs to file and exports a list of results)
# gams.species <- runGams(df = birds.grouped, group.var = "key", year.start = 1973,
#                         zero.thresh = 0.50, lr.alpha = 0.05, ll.thresh = 1.4,
#                         mod.sel.ind = "human")


# Simple GAMs per group ---------------------------------------------------
# Run the gam for species (ind by spp)
gam.results.ind <- runGams(df = birds.grouped, family = "quasipoisson",
                           group.var = "ind",
                           mod.formula  = as.formula("value ~ s(year, by = \"key\") + hours"),
                           fig.out.path = NULL,
                           year.start = 1973,
                           zero.thresh = 0.11,
                           length.out = 200)


# Run the gam for species (ind by spp)
gam.results.ind.sum <- runGams(df = birds.grouped, family = "quasipoisson",
                           group.var = "ind",
                           mod.formula  = as.formula("value ~ s(year) + hours"),
                           fig.out.path = NULL,
                           year.start = 1973,
                           zero.thresh = 0.11,
                           length.out = 200)

# Run the gam for species (key)
gam.results.key <- runGams(df = birds.grouped, family = "quasipoisson",
                   group.var = "key",
                   mod.formula  = as.formula("value ~ s(year) + hours"),
                   fig.out.path = NULL,
                   year.start = 1973,
                   zero.thresh = 0.11,
                   length.out = 200)
qq.gam(gam.results.ind[[9]])

plot(gam.results.ind[[1]], pages = 1, all.terms = T)


unique(gam.results.ind[[1]]$coefficients %>% names())

d<-derivatives(gam.results.key[[1]])
?derivatives
d1<-derivatives(gam.results.ind[[1]], term = "year")
ggplot(d, aes(x = data, ))

y=plot(gam.results.ind[[1]])
draw(derivatives(gam.results.key[[92]]))
?draw.derivatives

# These are the species for which we don't have analysis.
ts = birds.grouped %>% filter(key == "House Finch")%>% distinct(year, key, .keep_all = T)



# ARIMA MODELING -------------------------------------------------------
# https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/
# install.packages("fUnitRoots") # If you already have installed this package, you can omit this line
library(fUnitRoots);
# Follow those steps to try to automate the selection via visualization^^^
x <- birds.grouped %>%
    filter(ind == index[i])
    # filter(key == index[i])

plot(x$value ~ x$year, type = "l")
plot(log(x$value) ~ x$year, type = "l")
# test for stationarity
adfTest(diff(x$value), lags = 1)
adfTest(diff(x$value), lags = 2)
adfTest(diff(x$value), lags = 3)

?adfTest
