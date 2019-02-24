#' @param df A data frame with at least columns year, key (speciesID)
#' @param missingSpp A character vector of species that were missing from NACC list.
#' @param ignore Character vector of species to ignore from missingSpp (i.e., these will be included in species richness estimate).
#' @export estRichness
#' @description Estimates total species richness after munging the data, and removing the non-species-specific IDs.
estRichness <- function(df, missingSpp, ignore = NULL){

    # detach("package:plyr", unload=TRUE)


    filter.out.spp <- missingSpp[!missingSpp %in% ignore]


    y <- df %>%
        filter(!key %in% missingSpp) %>%
        filter(value > 0 &
               !is.na(value)) %>%
        dplyr::select(key, year)%>%
        as.data.frame() %>%
        mutate(key = as.factor(key)) %>%
       distinct(key, year) %>%   # just to be safe!
group_by(year) %>%
        summarise(rich = n())



return(y)
    }
