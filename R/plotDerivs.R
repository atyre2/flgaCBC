#' @description Calculate finite diffs and plot GAMS. This is to be used INSIDE the runGams function.
#' @export getAndPlotDerivs
#' @param myMod The model gam
#' @param gam.data Model of class gam and lme
#' @param length Length of predited data frame
#' @fig.ind Figure index, for naming plot files
#' @param term Term for plotting.

getAndPlotDerivs <- function(myMod, gam.data, length = 200, fig.ind = index[i], term = "year"){
myMod <- gams.groups$bestModels[[1]]

# pdat <- get.pdat(gam.data, 200)

# Create new data for making predictions
want <- seq(1, nrow(gam.data), length.out = length)
newdata <- with(gam.data,
                data.frame(year = year[want], hours = hours[want]))


myMod.d <- Deriv(mod = myMod, n = 200, newdata = newdata)

# stack both terms
png(paste0(fig.out.path, "derivs_allTerms_",fig.ind,".png"))
plot(myMod.d, sizer = T, alpha = 0.01)
dev.off()

# ONLY specified term
if(exists("term")){
png(paste0(fig.out.path, "derivs_term", term, "_",fig.ind,".png"))
plot(best.model.d, sizer = T, alpha = 0.01, term = "year")
dev.off()
    }


png("/users/jessicaburnett/downloads/test.png")
plot(value ~ year, data = gam.data, type = "p", ylab = "ylab")
lines(p2 ~ year, data = pdat)

CI <- confint(myMod.d, alpha = 0.01)
S <- signifD(p2, myMod.d$year$deriv, CI$year$upper, CI$year$lower,
             eval = 0)
lines(S$incr ~ year, data = pdat, lwd = 3, col = "blue")
lines(S$decr ~ year, data = pdat, lwd = 3, col = "red")

dev.off()


# Plot uncorrelated error model (for year) with best model when get.error.plots ==T
if(get.error.plots){

    plot.lab <- plot.lab
    plot.lab <- paste0("AR(", plot.lab, ") Errors")
    # Save plots
    # dev.new()
    png(paste0(fig.out.path,"arModPreds_",index[i] ,".png"))
    plot(value ~ year , data = gam.data, type = "p", ylab = paste0(index[i]))

    lines(p1 ~ year, data = pdat, col = "red")
    lines(p2 ~ year, data = pdat, col = "blue")
    legend("topleft",
           legend = c("Uncorrelated Errors", plot.lab),
           bty = "n", col = c("red","blue"), lty = 1)
    dev.off()

}
}

