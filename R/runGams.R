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
#' @param mod.formula Class formula. If blank default value ~ s(year) + hours
#' @param ll.thresh Loglikthood ratio cutoff. Default 1.5
#' @param mod.sel.ind Criterion for choosing best AR model when AR fits better than non-AR. Right now only have logLik.
runGams <- function(df = birds.grouped,
                    mod.formula  = as.formula("value ~ s(year) + hours"),
                    family = "quasipoisson",
                    lr.alpha = 0.05,
                    group.var,
                    fig.out.path = NULL,
                    year.start = 0000,
                    year.end = 9999,
                    zero.thresh = 0.25,
                    ll.thresh = 1.5,
                    # mod.sel.ind="human",
                    skip = NULL,
                    run.ar = FALSE,
                    length.out = 200
                    ){

# Directories -------------------------------------------------------------------

if(is.null(fig.out.path)) fig.out.path <- paste0(here::here(), "/Figures/")

# Create dir if it does not exist
dir.create(paste0(here::here(), "/Results"))
dir.create(fig.out.path)


# DATA MUNGING ------------------------------------------------------------
# Do some data munging...
df <- df %>%
    # dplyr::select(year, hours, group.var, value), %>%
        rename(group.var = group.var) %>%
        na.omit(group.var) %>%
        filter(year >= year.start & year.end <= year.end) %>%
        mutate(group.var= as.character(group.var)) %>%
        distinct(.keep_all=T)

# Need to get a character vector for labelling purposes.
    if(is.factor(df$group.var)){
        index <- levels(df$group.var)
        }else(index <- unique(df$group.var))

# CALC GAMS ---------------------------------------------------------------
# Create empty lists to fill in the loop
gam.results <- list()

 # Run gams over each group within a loop. Saves plots to file and results to lists.
       for (i in 1:length(index)) {

       if(index[i] %in% skip){
           print(paste0("skipping for convergence issues: ", index[i]))
           next}

       ## Filter the data based on index
       if(group.var == "key")
           gam.data <- df %>%
               filter(group.var == index[i]) %>%
               group_by(year, group.var) %>%
               mutate(value = sum(value)) %>%
               distinct(group.var, year, .keep_all = T)

       if(group.var == "ind" & mod.formula  == "value ~ s(year, by = \"key\") + hours"){
           thresh = zero.thresh*nrow(df %>% distinct(year))
           gam.data <- df %>%
               filter(group.var == index[i]) %>%
               group_by(year, group.var, key) %>%
               mutate(value = sum(value)) %>%
               distinct(key, year, group.var, .keep_all = T) %>%
               ungroup()
           spp.keep <- gam.data %>%
               filter(value >0) %>%
               group_by(group.var, key) %>%
               mutate(n = n()) %>%
               filter(n > thresh) %>%
               ungroup() %>% #just in case!
               distinct(key)
            gam.data <- gam.data %>% filter(key %in% spp.keep$key)

            mod.formula <- as.formula(value ~ s(year, by = as.factor(key)) + hours)
               }


       if(group.var == "ind" & mod.formula  != "value ~ s(year, by = \"key\") + hours")
           gam.data <- df %>%
               filter(group.var == index[i]) %>%
               group_by(year, group.var) %>%
               mutate(value = sum(value)) %>%
               ungroup() %>%
               distinct(year, group.var, .keep_all = T)



       # Skip if too many zeroes or not enough data
       zero.count <- gam.data %>%
           filter(value == 0) %>%
           nrow()


       if(zero.count > zero.thresh * nrow(gam.data)){
           print(paste0("Skipping index: ", index[i], ", exceeds zero.thresh"));
           next}

       if(nrow(gam.data) < 15){
           print(paste0("Less than 15 obervations. Skipping: ", index[i]))
           next}

       ## Create GAMMs AND build
        ## NOTE: For count data consider poisson (mean=var) and quasi-poisson models (quasi meaning variance is assumed to be a linear function of the mean) models
       ## Clear the previous models before running new ones

       gam.results[[i]] =
                mgcv::gam(
                    mod.formula,
                    method = "REML",
                    data = gam.data,
                    family = family)
       gamplots.dir <- paste0(fig.out.path, "gamPlots/")
       dir.create(gamplots.dir)
       pdf(file = paste0(gamplots.dir, "gamPlots_", group.var, "_", index[[i]], Sys.Date(),".pdf"))
       plot(gam.results[[i]])
        dev.off()
       names(gam.results)[[i]] <- index[i]

        # Run ar-X models.
        # if(run.ar){
        #     m.ar1 <- m.ar2 <- m.ar3 <- NULL
        #     m.ar1 =
        #         mgcv::gamm(
        #             value ~ s(year) + hours,
        #             method = "REML",
        #             data = gam.data,
        #             correlation = corARMA(form = ~ year, p = 1),
        #             family = family)
        #     m.ar2  =
        #         mgcv::gamm(
        #             value ~ s(year) + hours,
        #             method = "REML",
        #             data = gam.data,
        #             correlation = corARMA(form = ~  year, p = 2),
        #             family = family)
        #     m.ar3  =
        #         mgcv::gamm(
        #             value ~ s(year) + hours,
        #             method = "REML",
        #             data = gam.data,
        #             correlation = corARMA(form = ~ year, p = 3),
        #             family = family)
        #         }


} # END FOR LOOP I

# remove the empty elements (species/groups skipped)
gam.results <- Filter(Negate(is.null), gam.results)

# save to file
saveRDS(gam.results, paste0(here(),"/Results/gamResults_", group.var, Sys.Date(),".rds"))


return(gam.results)


}# END FUNCTION


