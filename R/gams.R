#' @param df A data frame with at least the following columns: year, hours,  and one of kgrouping variable over which counts will be summed).
#' @param lr.alpha p-value for cutoff of likelihood ratio test for comparing AR-X models with AR0
#' @param group.var The column name of the grouping variable (e.g., group.var = "species").
#' @param year.start Keeps data after year.start, including this year.
#' @param year.end Keeps data prior to year .end, including this year.
#' @export runGams Runs gams on groups of birds.
#' @param fig.out.path File location for saving figures out
#' @param  get.error.plots Logical. T will print error plots for best vs. AR0 model to file.
#' @param zero.thresh Proportion (between 0 and 1) of data which must have non-zero observations. If too low, some models may not converge.

runGams <- function(birds.grouped,
                    lr.alpha = 0.05,
                    group.var,
                    fig.out.path = paste0(here::here(), "/Figures/"),
                    year.start = 0000,
                    year.end = 9999,
                    zero.thresh = 0.50,
                    get.error.plots = F
                    ){

# Get Deriv() function if doesnot already exist in env
if(!exists("Deriv", mode="function")){
    source("https://github.com/gavinsimpson/random_code/raw/master/derivFun.R")}


# Create dir if it does not exist
dir.create(fig.out.path)

# Do some data munging...
    {
     df <- birds.grouped %>% dplyr::select(year, hours, group.var, value) %>%
        na.omit(group.var) %>%
                rename(group.var = group.var) %>%
                filter(year >= year.start & year.end <= year.end) %>%
                mutate(group.var= as.character(group.var)) %>%
                group_by(year, group.var) %>%
                mutate(value = sum(value)) %>%
                distinct(year, hours,value,group.var)

    # Need to get a character vector for labelling purposes.
    if(is.factor(df$group.var)){
        index <- levels(df$group.var)
        }else(index <- unique(df$group.var))

    }

# Create empty lists to fill in the loop
    best.gam.results <- list()
    best.mod.LRresults <- list()

 # Run gams over each group within a loop. Saves plots to file and results to lists.
       for (i in 1:length(index)) {

       ## Filter the data
       gam.data <- df %>%
            filter(group.var == index[i])

       # Skip if too many zeroes
       zero.count <- gam.data %>%
           filter(value == 0) %>%
           nrow()

       if(zero.count > zero.thresh * nrow(gam.data)){
           print(paste0("Skipping index: ", index[i], ", exceeds zero.thresh"));
           next}
       ## Create and run models
        {
            ar0.gam =
                gamm(
                    value ~ s(year) + hours,
                    method = "REML",
                    data = gam.data)


            ar1.gam =
                gamm(
                    value ~ s(year) + hours,
                    method = "REML",
                    data = gam.data,
                    correlation = corARMA(form = ~ year, p = 1)
                )

            ar2.gam  =
                gamm(
                    value ~ s(year) + hours,
                    method = "REML",
                    data = gam.data,
                    correlation = corARMA(form = ~ year, p = 2)
                )
            ar3.gam =
                gamm(
                    value ~ s(year) + hours,
                    method = "REML",
                    data = gam.data,
                    correlation = corARMA(form = ~ year, p = 3)
                )

            # Keep the best fitting model
            (aov.tab = anova(ar0.gam$lme, ar1.gam$lme,ar2.gam$lme, ar3.gam$lme))

            lr.alpha = lr.alpha

            best.mod.LRresults[[i]] = aov.tab %>%
                filter(`p-value` <= lr.alpha) %>%
                slice(which.max(logLik)) %>%
                mutate(modelName = paste0("ar", Model, ".gam")) %>%
                rename(plot.lab = Model) %>%
                select(modelName, plot.lab,df, AIC, BIC, logLik, L.Ratio, "p-value") %>%
                mutate(group = paste0(index[i]))

            best.gam.results[[i]] <- get(best.mod$modelName)
            }

     ## Make get errors df
     if(get.error.plots){
               {
                 pdat <- data.frame(year = min(gam.data$year):max(gam.data$year),
                                   hours = seq(1,max(gam.data$hours),
                                               length = (max(gam.data$year)-min(gam.data$year)+1)))
                p1 <- predict(ar0.gam$gam, newdata = pdat)
                p2 <- predict(best.gam.results[[i]]$gam, newdata = pdat)
}

      # Plot uncorrelated error model (for year) with best model
        {
            plot.lab <- best.mod.LRresults[[i]]$plot.lab
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

        }}


     ## Derivative plots
      best.mod <- best.gam.results[[i]]

       m2.d <- Deriv(best.mod, n = 200)
       plot(m2.d, sizer = TRUE, alpha = 0.01)




} # end for loop i

 # Combine lists for function export
    gamResults.list <- list(best.mod.LRresults, best.gam.results)
    names(gamResults.list) <- c("LRresults", "bestGamModelResults")

    return(gamResults.list)
} # end function
