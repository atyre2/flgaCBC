# ####################################################################################################################################################################################
# ####################################################################################################################################################################################
# #### This script is used to group some species (as suggested by A. Kratter) for the trend modelling.
# #### We are grouping species through years 1960 to 2015.
# ####################################################################################################################################################################################
# # Clear Workspace
# ####################################################################################################################################################################################
# rm(list = ls())
#
# ########################################################################################################################
# ## Load Libraries
# ########################################################################################################################
# #install.packages(c("tidyverse","sqldf","stringr"))
# # Load Data --------------------------------------------------------------
# #   read.csv("birds.keep.csv") # CBC counts for INIDIVDUAL SpECIES
# birds <-
#   read.csv("CBC_flga_1957to2015.csv", stringsAsFactors = FALSE, check.names = F)
# birds <- birds %>%
# filter(year >= 2015-30)
#
#
#
# # Cleaning ----------------------------------------------------------------
# # Replace colnames with edited spp names
# library(reshape2)
# names(birds) <- edit.names
# sort(names(birds))
#
# # Create df for Species-level analysis ------------------------------------
# ## I have to melt and then cast to account for duplicate colnames. This will simply add them up upon dcast.
# spp.long <-
#      melt(birds[c(1, 2 , 5:ncol(birds))], id.vars= c("Year", "Hours"), variable.name = "common_name", value.name = "count")
#
# spp.analysis <- dcast(spp.long, Year + Hours ~ common_name )
#
#
# # Bring in NACC species and edit to match CBC ------------------------------------------------------------------------
# ## Let's bring in the NACC List to quickly subset by familiy
# nacc.list <-  as.data.frame(read.csv("NACC_list_species.csv"))
# nacc.list.names <- gsub("-", " ", nacc.list$common_name)
# nacc.list.names <- gsub("Rock Pigeon", "Rock Dove", nacc.list.names)
# nacc.list$common_name <-  nacc.list.names
# nacc.list$common_name <-
#   str_to_title(nacc.list$common_name) ## Let's force Title Case to the species to match NACC List
#
#
# # Ensuring all relevant spp. in birds are in NACC.list --------------------
# a1 <- data.frame(edit.names)
# a2 <- data.frame(nacc.list$common_name)
# (a1NotIna2 <-
#   sqldf('SELECT * FROM a1 EXCEPT SELECT * FROM a2'))##  HAVING PROBLEMS NOW =-- RECHEcK ORDER OF EDIT.NAMES calls!
#
#
#
# # Grouping ----------------------------------------------------------------
# ## Create groups of bird families or orders by which to subset the BBS/CBC data
# ## Let the grouping begin!
# str(nacc.list)
# str(birds2)
# new.spp.list <-
#   merge(birds2, nacc.list , by = "common_name", all.x = T)
# new.spp.list$common_name <- as.factor(new.spp.list$common_name)
# new.spp.list$count <- as.integer(new.spp.list$count)
# new.spp.list$count[is.na(new.spp.list$count)] <- 0
# ###### Create a function for summing over groups for subsetting
# ################################################################################################
# sum.species.groups <- function(x)
#   aggregate(cbind(count, Hours)  ~ Year, FUN = sum, data = x) #This is when working with DATA FRAMES only
#
# #sum.species.groups.list <- function(x) #This is when working with LISTS of data frames only
# #  aggregate(count ~ x[[1]], FUN = sum, data = x)
#
# ####################################################################################
# ## Raptor subset
# raptors.subset <- droplevels(new.spp.list %>%
#   filter(common_name  %in% c("Cooper'S Hawk", "American Kestrel", "Bald Eagle",
#                               "Bald Eagle.1", "Bald Eagle.2", "Bald Eagle.3",
#                              "Broad Winged Hawk", "Merlin", "Northern Harrier","Osprey",
#                              "Peregrine Falcon", "Red Shouldered Hawk","Red Tailed Hawk",
#                              "Rough Legged Hawk","Sharp Shinned Hawk", ""
#                              )))
#
# unique(raptors.subset$common_name)
#  ####################################################################################
# ## Insectivorous Open Country
# insect.open <- droplevels(new.spp.list %>%
#                             filter(
#                               common_name %in% c(
#                                 "Eastern Phoebe",
#                                 "Yellow Rumped Warbler",
#                                 "Common Yellowthroat",
#                                 "White Eyed Vireo",
#                                 "Orange Crowned Warbler",
#                                 "Palm Warbler",
#                                 "Blue Gray Gnatcatcher"
#                               )
#                             ))
#
# ####################################################################################
# ## Common Open Country
# comm.open <- droplevels(new.spp.list %>%
#                           filter(
#                             common_name %in% c(
#                               "Eastern Phoebe",
#                               "Yellow Rumped Warbler",
#                               "Common Yellowthroat",
#                               "White Eyed Vireo",
#                               "Orange Crowned Warbler",
#                               "Palm Warbler",
#                               "Blue Gray Gnatcatcher",
#                               "Eastern Bluebird",
#                               "Eastern Towhee",
#                               "Northern Mockingbird",
#                               "Brown Thrasher",
#                               "Swamp Sparrow",
#                               "Gray Catbird"
#                             )
#                           ))
# unique(comm.open$common_name)
#
# # Common Mixed Flockers without YRWA --------------------------------------
#
# comm.mf <- droplevels(new.spp.list[new.spp.list$common_name %in% c(
#   "Tufted Titmouse",
#   "Yellow Rumped Warbler",
#   "Blue Headed Vireo",
#   "Downy Woodpecker" ,
#   "Carolina Chickadee",
#   "Blue Gray Gnatcatcher",
#   "Ruby Crowned Kinglet",
#   "Orange Crowned Warbler",
#   "Yellow Throated Warbler",
#   "Black and White Warbler"
# ),])
# # ## Common Mixed Flockers without YRWA -----------------------------------
# comm.mf.NOYRWA <-
#   droplevels(new.spp.list[new.spp.list$common_name %in% c(
#     "Tufted Titmouse",
#     "Downy Woodpecker" ,
#     "Carolina Chickadee",
#     "Blue Headed Vireo",
#     "Blue Gray Gnatcatcher",
#     "Ruby Crowned Kinglet",
#     "Orange Crowned Warbler",
#     "Yellow Throated Warbler",
#     "Black and White Warbler"
#   ),])
#
#
#
# unique(comm.mf$common_name)
#
#
# # ## Rare Neotropical Migrant Passerines ----------------------------------
# rare.neo.mig <-
#   new.spp.list %>% filter (
#     common_name %in% c(
#       "American Redstart",
#       "Ash Throated Flycatcher",
#       "Baltimore Oriole",
#       "Black and White Warbler",
#       "Black Throated Blue Warbler",
#       "Black Throated Green Warbler",
#       "Blackburnian Warbler",
#       "Blue Winged Warbler",
#       "Brown Crested Flycatcher",
#       "Bullock'S Oriole",
#       "Eastern Kingbird",
#       "Indigo Bunting",
#       "Least Flycatcher",
#       "Louisiana Waterthrush",
#       "Magnolia Warbler",
#       "Nashville Warbler",
#       "Northern Parula",
#       "Northern Waterthrush",
#       "Orchard Oriole",
#       "Painted Bunting",
#       "Ovenbird",
#       "Prairie Warbler",
#       "Tennessee Warbler",
#       "Yellow Breasted Chat",
#       "Yellow Warbler",
#       "Western Kingbird",
#       "Wilson'S Warbler",
#       "Western Tanager",
#       "Vermilion Flycatcher",
#       "Summer Tanager"
#     )
#   )
#
#
# # ## MAKING DF OF WARBLERS for #warb/year ---------------------------------
#
# warblers.all <-
#   droplevels(new.spp.list %>% filter(family %in% "Parulidae"))
# warblers.all <-
#   rbind(warblers.all, new.spp.list %>% filter (common_name %in% c(
#     "Black and White Warbler", "Wilson'S Warbler"
#   )))
# unique(warblers.all$common_name)
#
#
# # ## All warblers except YRWA, COYE, PAWA, PIWA ---------------------------
#
# warblers.uncommon <-   droplevels(new.spp.list %>%
#                                     filter(family %in% c("Parulidae") , !(
#                                       common_name %in% c(
#                                         "Common Yellowthroat",
#                                         "Yellow Rumped Warbler",
#                                         "Palm Warbler",
#                                         "Pine Warbler"
#                                       )
#                                     )))
# warblers.uncommon <- rbind(warblers.uncommon,
#                            new.spp.list %>% filter(common_name %in% c(
#                              "Black and White Warbler", "Wilson'S Warbler"
#                            )))
# unique(warblers.uncommon$common_name)
#
#
# # HUmmers -----------------------------------------------------------------
# hummers <-
#   droplevels(new.spp.list %>%
#                filter(
#                  family %in% c("Trochilidae") |
#                    common_name %in% c("H Bird") |
#                    common_name %in% c("Humm")
#                ))
#
#
# # Pulling it together -----------------------------------------------------
# # Sum species over rows to obtain one observation per species per year.
# all.comm.open <- sum.species.groups(comm.open)
# all.comm.open$logbpph <- log((all.comm.open$count+0.000000000000001)/all.comm.open$Hours)
# all.insect.open <- sum.species.groups(insect.open)
# all.insect.open$logbpph <- log((all.insect.open$count+0.000000000000001)/all.insect.open$Hours)
# all.rare.neo.mig <- sum.species.groups(rare.neo.mig)
# all.rare.neo.mig$logbpph <- log((all.rare.neo.mig$count+0.000000000000001)/all.rare.neo.mig$Hours)
# all.uncom.warblers <- sum.species.groups(warblers.uncommon)
# all.uncom.warblers$logbpph <- log((all.uncom.warblers$count+0.000000000000001)/all.uncom.warblers$Hours)
# all.warblers <- sum.species.groups(warblers.all)
# all.warblers$logbpph <- log((all.warblers$count+0.000000000000001)/all.warblers$Hours)
# common.mfers <- sum.species.groups(comm.mf)
# common.mfers$logbpph <- log((common.mfers$count+0.000000000000001)/common.mfers$Hours)
# comm.mf.NOYRWA1 <- sum.species.groups(comm.mf.NOYRWA) ####
# comm.mf.NOYRWA1$logbpph <- log((comm.mf.NOYRWA1$count+0.000000000000001)/comm.mf.NOYRWA1$Hours)
# subset.raptors <- sum.species.groups(raptors.subset)
# subset.raptors$logbpph <- log((subset.raptors$count+0.000000000000001)/subset.raptors$Hours)
# all.hummers <- sum.species.groups(hummers)
# all.hummers$logbpph <- log((all.hummers$count+0.000000000000001)/all.hummers$Hours)
#
# ### Create a List to use in GAM(s) "cbc_poptrends_ffn_Sept16.R"
# groups.forgam <- list(
#   "Common Open Foragers" = all.comm.open,
#
#   "Open Insectivores" = all.insect.open,
#   "Rare Neomigrants" = all.rare.neo.mig,
#   "Uncommon Warblers" = all.uncom.warblers,
#
#   "Warblers" = all.warblers,
#
#   "Common Mixed Flockers" = common.mfers,
#
#   "Common Mixed Flockers (no YRWA)" = comm.mf.NOYRWA1,
#   "Raptors" = subset.raptors,
#   "Hummingbirds" = all.hummers
# )
#
# # Data Check --------------------------------------------------------------
# unique(comm.open$common_name)
# unique(insect.open$common_name)
# unique(rare.neo.mig$common_name)
# unique(warblers.uncommon$common_name)
# unique(warblers.all$common_name)
# unique(comm.mf$common_name)
# unique(comm.mf.NOYRWA$common_name)
# unique(raptors.subset$common_name)
# unique(hummers$species)
