#' @description Create species groups for grouped population trends
#' @param df A dataframe containing species names and taxonomies (must include family, order, and common name)
#' @export speciesGroups


speciesGroups <- function(df){


# 1. Neotropical Migrants
neotropMig.spp <- c(
    "American Redstart",
    "Ash Throated Flycatcher",
    "Baltimore Oriole",
    "Black-Chinned Hummingbird",
    "Black-And-White Warbler",
    # "Black & White Warbler", # just in case
    # "Black&White Warbler",   # just in case
    "Black-Headed Grosbeak",
    "Black-Throated Blue Warbler",
    # "Black-Throated Green Warbler",
    # "Blackburnian Warbler",
    # "Blue Winged Warbler",
    # "Brown Crested Flycatcher",
    # "Bullock'S Oriole",
    "Cape May Warbler",
    "Chestnut-Sided Warbler",
    "Dickcissel",
    # "Eastern Kingbird",
    "Eastern Whip-Poor-Will",
    "Great-Crested Flycatcher",
    "Hooded Warbler",
    "Indigo Bunting",
    "Kentucky Warbler",
    # "Least Flycatcher",
    "Louisiana Waterthrush",
    "Magnolia Warbler",
    "Nashville Warbler",
    "Northern Parula",
    "Northern Waterthrush",
    # "Orchard Oriole",
    "Ovenbird",
    "Painted Bunting",
    "Prairie Warbler",
    "Rose-Breasted Grosbeak",
    "Ruby-Throated Hummingbird",
    "Rufous Hummingbird",
    "Summer Tanager",
    # "Tennessee Warbler",
    # "Tree Swallow",
    "Yellow Breasted Chat",
    # "Yellow Warbler",
    # "Western Kingbird",
    "Western Tanager",
    "Wilson's Warbler",
    "Vaux's Swift",
    "Vermilion Flycatcher",
    "Wood Thrush",
    "Worm-Eating Warbler",
    "Yellow-Throated Vireo"
)

# 2. Shrot-distance migrants
shortDistMig.spp <- c(
    "American Woodcock",
    "Brown Creeper",
    "Common Grackle",
    "Dark-Eyed Junco",
    "Eastern Towhee",
    "Fox Sparrow",
    "Golden-Crowned Kinglet",
    "Hermit Thrush",
    "Northern Harrier",
    "Pine Siskin",
    "Purple Finch",
    "Red-Breasted Nuthatch",
    "Red-Winged Blackbird",
    "Rusty Blackbird",
    "Sandhill Crane",
    "Song Sparrow",
    "Sharp-Shinned Hawk",
    "Vesper Sparrow",
    "White-Throated Sparrow",
    "Winter Wren",
    "White-Crowned Sparrow"
)

# 3. Regional endemic species
regionEndem.spp <- c(
    "Bachman's Sparrow",
    "Brown-Headed Nuthatch",
    "Red-Cockaded Woodpecker"
)


# 4. Widespread declining species
wideDecline.spp <- c(
    "Brown Thrasher",
    "Common Ground-Dove",
    "Eastern Meadowlark",
    "Field Sparrow",
    "Grasshopper Sparrow",
    "Henslow's Sparrow",
    "Loggerhead Shrike",
    # NOFL what is this?
    "Northern Bobwhite",
    "Red-Headed Woodpecker"
)

# 5. Non-native species
nn.spp <-c(
    "Black-Bellied Whistling-Duck",
    "European Starling",
    "Eurasian Collared-Dove",
    "House Sparrow",
    "Mallard",
    "Mallard-Feral",
    # MUDU what is this?
    "Rock Dove"

)

# 6. Spp. with North Florida as center of wintering range?
noflWinter.spp <- c(
"American Crow",
"American Goldfinch",
"American Robin",
    "Black-And-White-Warbler",
    # "Black & White-Warbler", # just in case
    # "Black&White-Warbler",
    "Blue-Gray Gnatcatcher",
    "Blue-Headed Vireo",
"Brown-Headed Cowbird",
"Brown Thrasher",
"Common Yellowthroat",
"Belted Kingfisher",
"Blue Jay",
# "Cedar Waxwing", ## is this what he meant by CEWX
"Carolina Chickadee",
"Carolina Wren",
"Chipping Sparrow",
    "Mourning Dove",
"Downy Woodpecker",
"Eastern Bluebird",
"Eastern Phoebe",
"Fish Crow",
"Gray Catbird",
"House Wren",
"Killdeer",
"Northern MockingBird",
"Northern Cardinal",
"Orange-Crowned Warbler",
"Palm Warbler",
"Pine Warbler",
"Sedge Wren",
"Red-Bellied Woodpecker",
"Ruby Crowned Kinglet",
"Swamp Sparrow",
"Tufted Titmouse",
"White-Eyed Vireo",
"Yellow-Bellied Sapsucker",
"Yellow-Rumped Warbler",
"Yellow-Throated Warbler"
    # WISN what is this?

)

# 7. Spp affected by DDT
ddt.spp <- c(
"Bald Eagle",
"Cooper's Hawk",
"Double-Crested Cormorant",
"Osprey",
"Merlin",
"Peregrine Falcon",
"Red-Shouldered Hawk",
"Sharp-Shinned Hawk"
)

# 8. Species influenced by Sweetwater PReserve in Gainesville, FL
sweetwater.spp <- c(
    "American Bittern",
    "Anhinga",
    "Blue-Winged Teal",
    # COGA what is this?
    "Double-Crested Cormorant",
    "King Rail",
    "Marsh Wren",
    "Least Bittern",
    "Limpkin",
    # NOSH what is this
    "Purple Gallinule",
    "Snail Kite",
    "Sora",
    "Virginia Rail",
    # all herons
    "Great Blue Heron",
    "Little Blue Heron",
    "Tricolored Heron",
    "Green Heron",
    "Black-Crowned Night-Heron",
    "Yellow-Crowned Night-Heron",
    # all ibis
    "White Ibis",
    "Glossy Ibis",
    "White-Faced Ibis",
    # stork
    "Wood Stork"
)


# 9. Urban adapters
urban.spp <- c(
    nn.spp, # non-native species from above
    "American Crow",
    "Barn Owl",
    "Blue Jay",
    "Black-Bellied Whistling-Duck",
    "Black Vulture",
"Boat-Tailed Grackle",
"Brown-Headed Cowbird",
"Brown Thrasher",
"Common Grackle",
    "Canada Goose",
    "Carolina Chickadee",
    "Carolina Wren",
# "Chipping Sparrow", # not really urban but yes to feeder
# "Common Ground-Dove", # Andy says no
    "Eastern Screech-Owl",
# "Eastern Towhee", # Andy says no
    "Fish Crow",
"Great-Horned Owl",
    "Hooded Merganser",
"House Finch",
    "House Wren",
        "Mallard",
    "Mallard-Feral",
"Northern Cardinal",
"Pileated Woodpecker",
"Northern Mockingbird",
"Red-Shouldered Hawk",
    "Ring-Billed Gull",
"Tufted Titmouse",
    "Turkey Vulture",
"White Ibis",
"Wood Duck"
)


# 10. Agricultural changes
agLoss.spp <-c(
    "American Pipit",
    "American Kestrel",
    "Barn Owl",
    "Boat-Tailed Grackle",
    "Brown Thrasher",
    "Common Ground-Dove",
    "Common Grackle",
    "Eastern Bluebird",
    "Eastern Meadowlark",
    "Eastern Phoebe",
    "House Sparrow",
    # "Grasshopper Sparrow", #AK says no
    # "Henslow's Sparrow",  #AK says no
    "Field Sparrow",
    "Northern Mockingbird",
    "Killdeer",
    "Loggerhead Shrike",
    "Mourning Dove",
    # "Palm Warbler", # maybe
    "Northern Harrier",
    # "Segde Wren", # AK says no
    "Red-Winged Blackbird",
"Red-Tailed Hawk",
    "Vesper Sparrow"

)

# 11. Feeder species
feeder.spp <-c(
    "American Goldfinch",
    "American Crow",
    "Baltimore Oriole",
    "Brown-Headed Cowbird",
    "Blue Jay",
    "Carolina Chickadee",
    "Carolina Wren",
    "Chipping Sparrow",
    "Cooper's Hawk",
    "House Finch",
    "House Sparrow",
    "Indigo Bunting",
    "Northern Cardinal",
    "Mourning Dove",
    "Yellow-Throated Warbler",
    "Painted Bunting",
    "Pine Siskin",
    "Ring-Billed Gull",
    "Red-Bellied Woodpecker",
    "Red-Breasted Nuthatch",
    "Sharp-Shinned Hawk",
    "Tufted Titmouse"
)


sppList <- list(
    neotropMig.spp,
    shortDistMig.spp,
    regionEndem.spp,
    wideDecline.spp,
    nn.spp,
    noflWinter.spp,
    ddt.spp,
    sweetwater.spp,
    urban.spp,
    agLoss.spp,
    feeder.spp)

names(sppList) <-
    c(     "Neotropical migrants",
      "Short-distance migrants",
      "Locally endemic",
      "Widespread declining",
      "Non-native",
      "N. FL wintering center",
      "DDT-vics",
      "Sweetwater",
      "Urban adapters",
      "Ag-loss vics",
      "Feeder birds"
      )

return(sppList)


}





# END RUN -----------------------------------------------------------------


# # Raptors -----------------------------------------------------------------
#
# raptors.subset <- droplevels(new.spp.list %>%
#                                  filter(common_name  %in% c("Cooper'S Hawk", "American Kestrel", "Bald Eagle",
#                                                             "Bald Eagle.1", "Bald Eagle.2", "Bald Eagle.3",
#                                                             "Broad Winged Hawk", "Merlin", "Northern Harrier","Osprey",
#                                                             "Peregrine Falcon", "Red Shouldered Hawk","Red Tailed Hawk",
#                                                             "Rough Legged Hawk","Sharp Shinned Hawk", ""
#                                  )))
#
# unique(raptors.subset$common_name)
# # Insectivorous Open Country ----------------------------------------------
#
# insect.open <- droplevels(new.spp.list %>%
#                               filter(
#                                   common_name %in% c(
#                                       "Eastern Phoebe",
#                                       "Yellow Rumped Warbler",
#                                       "Common Yellowthroat",
#                                       "White Eyed Vireo",
#                                       "Orange Crowned Warbler",
#                                       "Palm Warbler",
#                                       "Blue-Gray Gnatcatcher"
#                                   )
#                               ))
#
# # Common Open Country -----------------------------------------------------
# comm.open <- droplevels(new.spp.list %>%
#                             filter(
#                                 common_name %in% c(
#                                     "Eastern Phoebe",
#                                     "Yellow Rumped Warbler",
#                                     "Common Yellowthroat",
#                                     "White Eyed Vireo",
#                                     "Orange Crowned Warbler",
#                                     "Palm Warbler",
#                                     "Blue Gray Gnatcatcher",
#                                     "Eastern Bluebird",
#                                     "Eastern Towhee",
#                                     "Northern Mockingbird",
#                                     "Brown Thrasher",
#                                     "Swamp Sparrow",
#                                     "Gray Catbird"
#                                 )
#                             ))
# unique(comm.open$common_name)

# # Common Mixed Flockers without YRWA --------------------------------------
# comm.mf <- droplevels(new.spp.list[new.spp.list$common_name %in% c(
#     "Tufted Titmouse",
#     "Yellow Rumped Warbler",
#     "Blue Headed Vireo",
#     "Downy Woodpecker" ,
#     "Carolina Chickadee",
#     "Blue Gray Gnatcatcher",
#     "Ruby Crowned Kinglet",
#     "Orange Crowned Warbler",
#     "Yellow Throated Warbler",
#     "Black and White Warbler"
# ),])
# # Common Mixed Flockers without YRWA -----------------------------------
# comm.mf.NOYRWA <-
#     droplevels(new.spp.list[new.spp.list$common_name %in% c(
#         "Tufted Titmouse",
#         "Downy Woodpecker" ,
#         "Carolina Chickadee",
#         "Blue Headed Vireo",
#         "Blue Gray Gnatcatcher",
#         "Ruby Crowned Kinglet",
#         "Orange Crowned Warbler",
#         "Yellow Throated Warbler",
#         "Black and White Warbler"
#     ),])
#
#
#
# # Rare Neotropical Migrant Passerines ----------------------------------
# rare.neo.mig <-
#     new.spp.list %>% filter (
#         common_name %in% c(
#             "American Redstart",
#             "Ash Throated Flycatcher",
#             "Baltimore Oriole",
#             "Black and White Warbler",
#             "Black Throated Blue Warbler",
#             "Black Throated Green Warbler",
#             "Blackburnian Warbler",
#             "Blue Winged Warbler",
#             "Brown Crested Flycatcher",
#             "Bullock'S Oriole",
#             "Eastern Kingbird",
#             "Indigo Bunting",
#             "Least Flycatcher",
#             "Louisiana Waterthrush",
#             "Magnolia Warbler",
#             "Nashville Warbler",
#             "Northern Parula",
#             "Northern Waterthrush",
#             "Orchard Oriole",
#             "Painted Bunting",
#             "Ovenbird",
#             "Prairie Warbler",
#             "Tennessee Warbler",
#             "Yellow Breasted Chat",
#             "Yellow Warbler",
#             "Western Kingbird",
#             "Wilson'S Warbler",
#             "Western Tanager",
#             "Vermilion Flycatcher",
#             "Summer Tanager"
#         )
#     )
#
#
# # Warblers ---------------------------------
#
# warblers.all <-
#     droplevels(new.spp.list %>% filter(family %in% "Parulidae"))
# warblers.all <-
#     rbind(warblers.all, new.spp.list %>% filter (common_name %in% c(
#         "Black and White Warbler", "Wilson'S Warbler"
#     )))
# unique(warblers.all$common_name)
#
#
# # All warblers except YRWA, COYE, PAWA, PIWA ---------------------------
#
# warblers.uncommon <-   droplevels(new.spp.list %>%
#                                       filter(family %in% c("Parulidae") , !(
#                                           common_name %in% c(
#                                               "Common Yellowthroat",
#                                               "Yellow Rumped Warbler",
#                                               "Palm Warbler",
#                                               "Pine Warbler"
#                                           )
#                                       )))
# warblers.uncommon <- rbind(warblers.uncommon,
#                            new.spp.list %>% filter(common_name %in% c(
#                                "Black and White Warbler", "Wilson'S Warbler"
#                            )))
# unique(warblers.uncommon$common_name)
#
#
# # HUmmers -----------------------------------------------------------------
# hummers <-
#     droplevels(new.spp.list %>%
#                    filter(
#                        family %in% c("Trochilidae") |
#                            common_name %in% c("H Bird") |
#                            common_name %in% c("Humm")
#                    ))
#
