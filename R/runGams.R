#' @param df A data frame with at least the following columns: year, hours,  and one of kgrouping variable over which counts will be summed).
#' @param lr.alpha p-value for cutoff of likelihood ratio test for comparing AR-X models with AR0
#' @param group.var The column name of the grouping variable (e.g., group.var = "species").
#' @param year.start Keeps data after year.start, including this year.
#' @param year.end Keeps data prior to year .end, including this year.
#' @export runGams Runs gams on groups of birds.
#' @param fig.out.path File location for saving figures out
#' @param length.out Default 200. Used for making predictions
#' @param zero.thresh Proportion (between 0 and 1) of data which must have non-zero observations. I.e., if data contains 50% zeroes and zero.thresh = 0.30 (30%), then it will not compute.
#' @param family Family for gam
#' @param ll.thresh Loglikthood ratio cutoff. Default 1.5
#' @param mod.sel.ind Criterion for choosing best AR model when AR fits better than non-AR. Right now only have logLik.
runGams <- function(df = birds.grouped,
                    family = "quasipoisson",
                    lr.alpha = 0.05,
                    group.var,
                    fig.out.path = NULL,
                    year.start = 0000,
                    year.end = 9999,
                    zero.thresh = 0.25,
                    ll.thresh = 1.5,
                    length.out = 200,
                    # mod.sel.ind = "logLik",
                    mod.sel.ind="human"
                    ){

# SETUP -------------------------------------------------------------------
# Get Deriv() function if doesnot already exist in env
if(!exists("Deriv", mode="function"))  source("https://github.com/gavinsimpson/random_code/raw/master/derivFun.R")
if(is.null(fig.out.path)) fig.out.path <- paste0(here::here(), "/Figures/")

# Create dir if it does not exist
dir.create(fig.out.path)

# DATA MUNGING ------------------------------------------------------------
# Do some data munging...
     df <- df %>% dplyr::select(year, hours, group.var, value) %>%
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

# CALC GAMS ---------------------------------------------------------------
# Create empty lists to fill in the loop
modNames <- NULL
mod.best <- list()

 # Run gams over each group within a loop. Saves plots to file and results to lists.
       for (i in 153:length(index)) {

           if(index[i] %in% skip){
               print(paste0("skipping for convergence issues: ", index[i]))
               next}
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


       ## Create GAMMs AND build
        ## NOTE: For count data consider poisson (mean=var) and quasi-poisson models (quasi meaning variance is assumed to be a linear function of the mean) models
       ## Clear the previous models before running new ones
       m <- m1 <- m2 <- m3 <- NULL

            m =
                mgcv::gamm(
                    value ~ s(year) + hours,
                    # method = "REML",
                    data = gam.data,
                    family = family)
            m1 =
                mgcv::gamm(
                    value ~ s(year) + hours,
                    method = "REML",
                    data = gam.data,
                    correlation = corARMA(form = ~ year, p = 1),
                    family = family)
            m2  =
                mgcv::gamm(
                    value ~ s(year) + hours,
                    method = "REML",
                    data = gam.data,
                    correlation = corARMA(form = ~  year, p = 2),
                    family = family)

            m3  =
                mgcv::gamm(
                    value ~ s(year) + hours,
                    method = "REML",
                    data = gam.data,
                    correlation = corARMA(form = ~ year, p = 3),
                    family = family)

       ## Find the best model
       if(family %in% c("poisson", "quasipoisson") & mod.sel.ind != "human"){
           # check if our AR models were worth a shit
           ## If NONE of the intervals do not cross zero, then we shoudl default to the GAM (model m)
           ## if estimate crosses zero. Since poisson, we can just see if all of these
              ## overlap zero then we will keep the non-AR model (m)
           m1.temp <- m2.temp <- m3.temp<- NULL
           modName.temp <- NULL

           if(!is.null(m1))  m1.temp <- min(intervals(m1$lme, which = "var-cov")$corStruct) <= 0 else(m1.temp = FALSE)
           if(!is.null(m2))  m2.temp <- min(intervals(m2$lme, which = "var-cov")$corStruct) <= 0 else(m2.temp = FALSE)
           if(!is.null(m3))  m3.temp <- min(intervals(m3$lme, which = "var-cov")$corStruct) <= 0 else(m3.temp = FALSE)

           ## Specify model m (non-AR) as winner if
           if( !(m1.temp | m2.temp | m3.temp) ) modName.temp <- 0

               ## if one or more estimates do not cross zero, choose the best fit according to LogLikelihood ratios
                if(mod.sel.ind == "logLik" & is.null(modName.temp)){
                    if(!is.null(m1))  lnL.m1 <- 2*log(abs(logLik(m1$lme))[1])
                    if(!is.null(m2))  lnL.m2 <- 2*log(abs(logLik(m2$lme))[1])
                    if(!is.null(m3))  lnL.m3 <- 2*log(abs(logLik(m3$lme))[1])

                    if(!(is.null(m1) | is.null(m2))) m1vm2 <- lnL.m1/lnL.m2 else(m1vm2 = 0)
                    if(!(is.null(m2) | is.null(m3))) m2vm3 <- lnL.m2/lnL.m3 else(m2vm3 = 0)
                    if(!(is.null(m3) |is.null(m2)))  m3vm2 <- lnL.m3/lnL.m2 else(m3vm2 = 100)

                        # choose 1, 2, or 3 based on LR ratio via ll.thresh
                        if( m1vm2 > ll.thresh)        modName.temp <- m1$lme$modelStruct$corStruct %>% length()
                        if( m2vm3 > ll.thresh)        modName.temp <- m2$lme$modelStruct$corStruct %>% length()
                        if( m3vm2 < 1-(ll.thresh-1) ) modName.temp <- m3$lme$modelStruct$corStruct %>% length()

                        } # END LOG-LIKELIHOOD approaches
          } # END POISSON if else statemaent
       ## For non-poisson family condut LR test
       if(!family %in% c("poisson", "quasipoisson")){
           # get h test results
           aov.tab = anova(m$lme, m1$lme, m2$lme, m3$lme)

           # if non-autocorrelated model is best, keep that.
           if(min(aov.tab$`p-value`, na.rm=T) > lr.alpha){
               modName.temp = 0
               # mod.best[[i]]  <- m
           }
           if(!min(aov.tab$`p-value`, na.rm=T) > lr.alpha){
               modName.temp <- aov.tab %>%
                filter(`p-value` < lr.alpha) %>%
                filter(L.Ratio == max(L.Ratio)) %>%
                select(Model)
               modName.temp = modName.temp$Model - 1
               }
       } # END NON-POISSON IF ELSE

       if(mod.sel.ind == "human"){
        print("Because Jessica cannot figure out a decent way to automate model selection when family = poisson, we ned to do some work. Prepare for prompts. Make choice wisely...")

           ## Get the predicted values
           want <- seq(1, nrow(dat), length.out = length.out)
           pdat <- with(dat,
                        data.frame(year = year[want], hours = hours[want]))

           ## predict trend contributions
           p  <- predict(m$gam,
                         newdata = pdat,
                         type = "terms",
                         se.fit = TRUE)
           p1 <- predict(m1$gam,
                         newdata = pdat,
                         type = "terms",
                         se.fit = TRUE)
           p2 <- predict(m2$gam,
                         newdata = pdat,
                         type = "terms",
                         se.fit = TRUE)
           p3 <- predict(m3$gam,
                         newdata = pdat,
                         type = "terms",
                         se.fit = TRUE)

           ## combine with the predictions data, including fitted and SEs
           pdat <- transform(
               pdat,
               p  = p$fit[, 2],  se  = p$se.fit[, 2],
               p1 = p1$fit[, 2], se1 = p1$se.fit[, 2],
               p2 = p2$fit[, 2], se2 = p2$se.fit[, 2],
               p3 = p3$fit[, 2], se3 = p3$se.fit[, 2]
           )


           pdat <- pdat %>% select(-se, -se1, -se2, -se3) %>%
               gather(key = "model", value = "pred", -year, -hours)

           ## Just to make sure the plot shows up
           ggplot()+
                # geom_point(data = gam.dataaes(x = year, y = value-mean(value)), color = "gray45")+
                geom_line(data = pdat, aes(x = year, y = pred, color = model))+
               # geom_jitter() +
                ylab("predicted value")+
                ggtitle(paste0(unique(gam.data$group.var)))
                # add preds
           fn <- paste0(fig.out.path,"modSelect_", gsub(" ", "",index[i]),".png")
           ggsave(fn,
                  last_plot())

           print(paste0("Please open file: ", fn))

        modName.temp <- as.integer(readline("Which plot should we keep??
                                             0: Uncorrelated errors (p)
                                             1: AR(1) model (p)
                                             2: AR(2) model (p2)
                                             3: AR(3) model (p3)"))

        }
# Save models -------------------------------------------------------------

## Munge the model selected
modNames  <- data.frame(
   modelName = paste0("ar", modName.temp, ".gam"),
   group = paste0(index[i]),
   arNum  = modName.temp,
   listNum = i
)  %>%
   rbind(modNames)


# Save the best model to a list of model results
if(modName.temp != 0)    mod.best[[i]]  <- get(paste0("m", modName.temp))
if(modName.temp == 0)    mod.best[[i]] <- m

} # END FOR LOOP I

# SAVE THE GAM RESULTS ---------------------------------------------

gamResults.list <- list(modNames, mod.best)
names(gamResults.list) <- c("modelNames", "bestModels")

dir.create(paste0(here::here(), "/Results"))
saveRDS(gamResults.list, paste0(here(),"/Results/gamResults", Sys.Date(),".rds"))

return(gamResults.list)


}# END FUNCTION


