#' @title Load NACC species list to allow for quick filtering of CBC species
#' @param naccURL URL location of the NACC speices checklist.
#' @export

getNACClist <- function(naccURL = "http://checklist.aou.org/taxa.csv?type=charset%3Dutf-8%3Bsubspecies%3Dno%3B",
                        remove.hypen = F){

nacc.list <- read.csv(url(naccURL))

# Remove the hyphens if true
if(remove.hypen){nacc.list$common_name <- gsub("-", " ", nacc.list$common_name)}


# Fix rock dove to match CBC categorization
nacc.list$common_name <- gsub("Rock Pigeon", "Rock Dove", nacc.list$common_name)


# Force to title case
nacc.list$common_name <-
    str_to_title(nacc.list$common_name)

return(nacc.list)

}
