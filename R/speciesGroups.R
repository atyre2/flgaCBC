#' @description Create species groups for grouped population trends
#' @param df A dataframe containing species names and taxonomies (must include family, order, and common name)
#' @export


speciesGroups <- function(df){


# 1. Neotropical Migrants
neotropMig.spp <- c(
    "American Redstart",
    "Ash Throated Flycatcher",
    "Baltimore Oriole",
    "Black-Chinned Hummingbird",
    "Black-And-White Warbler",
    "Black & White Warbler", # just in case
    "Black&White Warbler",   # just in case
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
    "Black & White-Warbler", # just in case
    "Black&White-Warbler",
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
    "Least Bittern",
    "Limpkin",
    # NOSH what is this
    "Purple Gallinule",
    "Snail Kite",
    "Sora",
    "Virginia Rail"

)


sweetwater.spp.aou <- c(

)

}

# END RUN -----------------------------------------------------------------


# Raptors -----------------------------------------------------------------

raptors.subset <- droplevels(new.spp.list %>%
                                 filter(common_name  %in% c("Cooper'S Hawk", "American Kestrel", "Bald Eagle",
                                                            "Bald Eagle.1", "Bald Eagle.2", "Bald Eagle.3",
                                                            "Broad Winged Hawk", "Merlin", "Northern Harrier","Osprey",
                                                            "Peregrine Falcon", "Red Shouldered Hawk","Red Tailed Hawk",
                                                            "Rough Legged Hawk","Sharp Shinned Hawk", ""
                                 )))

unique(raptors.subset$common_name)
# Insectivorous Open Country ----------------------------------------------

insect.open <- droplevels(new.spp.list %>%
                              filter(
                                  common_name %in% c(
                                      "Eastern Phoebe",
                                      "Yellow Rumped Warbler",
                                      "Common Yellowthroat",
                                      "White Eyed Vireo",
                                      "Orange Crowned Warbler",
                                      "Palm Warbler",
                                      "Blue-Gray Gnatcatcher"
                                  )
                              ))

# Common Open Country -----------------------------------------------------
comm.open <- droplevels(new.spp.list %>%
                            filter(
                                common_name %in% c(
                                    "Eastern Phoebe",
                                    "Yellow Rumped Warbler",
                                    "Common Yellowthroat",
                                    "White Eyed Vireo",
                                    "Orange Crowned Warbler",
                                    "Palm Warbler",
                                    "Blue Gray Gnatcatcher",
                                    "Eastern Bluebird",
                                    "Eastern Towhee",
                                    "Northern Mockingbird",
                                    "Brown Thrasher",
                                    "Swamp Sparrow",
                                    "Gray Catbird"
                                )
                            ))
unique(comm.open$common_name)

# Common Mixed Flockers without YRWA --------------------------------------

comm.mf <- droplevels(new.spp.list[new.spp.list$common_name %in% c(
    "Tufted Titmouse",
    "Yellow Rumped Warbler",
    "Blue Headed Vireo",
    "Downy Woodpecker" ,
    "Carolina Chickadee",
    "Blue Gray Gnatcatcher",
    "Ruby Crowned Kinglet",
    "Orange Crowned Warbler",
    "Yellow Throated Warbler",
    "Black and White Warbler"
),])
# Common Mixed Flockers without YRWA -----------------------------------
comm.mf.NOYRWA <-
    droplevels(new.spp.list[new.spp.list$common_name %in% c(
        "Tufted Titmouse",
        "Downy Woodpecker" ,
        "Carolina Chickadee",
        "Blue Headed Vireo",
        "Blue Gray Gnatcatcher",
        "Ruby Crowned Kinglet",
        "Orange Crowned Warbler",
        "Yellow Throated Warbler",
        "Black and White Warbler"
    ),])



# Rare Neotropical Migrant Passerines ----------------------------------
rare.neo.mig <-
    new.spp.list %>% filter (
        common_name %in% c(
            "American Redstart",
            "Ash Throated Flycatcher",
            "Baltimore Oriole",
            "Black and White Warbler",
            "Black Throated Blue Warbler",
            "Black Throated Green Warbler",
            "Blackburnian Warbler",
            "Blue Winged Warbler",
            "Brown Crested Flycatcher",
            "Bullock'S Oriole",
            "Eastern Kingbird",
            "Indigo Bunting",
            "Least Flycatcher",
            "Louisiana Waterthrush",
            "Magnolia Warbler",
            "Nashville Warbler",
            "Northern Parula",
            "Northern Waterthrush",
            "Orchard Oriole",
            "Painted Bunting",
            "Ovenbird",
            "Prairie Warbler",
            "Tennessee Warbler",
            "Yellow Breasted Chat",
            "Yellow Warbler",
            "Western Kingbird",
            "Wilson'S Warbler",
            "Western Tanager",
            "Vermilion Flycatcher",
            "Summer Tanager"
        )
    )


# Warblers ---------------------------------

warblers.all <-
    droplevels(new.spp.list %>% filter(family %in% "Parulidae"))
warblers.all <-
    rbind(warblers.all, new.spp.list %>% filter (common_name %in% c(
        "Black and White Warbler", "Wilson'S Warbler"
    )))
unique(warblers.all$common_name)


# All warblers except YRWA, COYE, PAWA, PIWA ---------------------------

warblers.uncommon <-   droplevels(new.spp.list %>%
                                      filter(family %in% c("Parulidae") , !(
                                          common_name %in% c(
                                              "Common Yellowthroat",
                                              "Yellow Rumped Warbler",
                                              "Palm Warbler",
                                              "Pine Warbler"
                                          )
                                      )))
warblers.uncommon <- rbind(warblers.uncommon,
                           new.spp.list %>% filter(common_name %in% c(
                               "Black and White Warbler", "Wilson'S Warbler"
                           )))
unique(warblers.uncommon$common_name)


# HUmmers -----------------------------------------------------------------
hummers <-
    droplevels(new.spp.list %>%
                   filter(
                       family %in% c("Trochilidae") |
                           common_name %in% c("H Bird") |
                           common_name %in% c("Humm")
                   ))

