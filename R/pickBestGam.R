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




gamResults.list <- list(modNames, mod.best)
names(gamResults.list) <- c("modelNames", "bestModels")

