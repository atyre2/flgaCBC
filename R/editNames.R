#' @title Fix species names on CBC list to correspond with NACC species list
#' @param df A data frame with header that includes variable key (== species common names).
#' @param return.wide Logical. If TRUE returns a wide data frame. Default = FALSE (long df).
#' @export editNames
#'
#'
editNames <- function(df, return.wide = FALSE){

df <-     df %>%
    mutate(key = str_to_title(key)) %>%
    # Fix some species names here, do not ove to edit names, because we will have to sum these while data is in long    format (see next call.)
    mutate(key = gsub(", sp.", " Sp." , key, fixed = T)) %>%
    mutate(key = gsub(", Sp.", " Sp." , key, fixed = T)) %>%
    mutate(key = gsub(" sp.", " Sp." , key, fixed = T)) %>%
        mutate(key = gsub("Bald Eagle, Adult", "Bald Eagle" , key, fixed = T)) %>%
        mutate(key = gsub("Bald Eagle, Immature", "Bald Eagle" , key, fixed = T)) %>%
        mutate(key = gsub("Bald Eagle Imm.", "Bald Eagle" , key, fixed = T)) %>%
        mutate(key = gsub("Bald Eagle, Unknown", "Bald Eagle" , key, fixed = T)) %>%
        mutate(key = gsub("Bald Eagle Unk.", "Bald Eagle" , key, fixed = T)) %>%
        mutate(key = gsub("Bald Eagle, Adult", "Bald Eagle" , key, fixed = T)) %>%
        mutate(key = gsub("Bald Eagle Ad.", "Bald Eagle" , key, fixed = T)) %>%
        mutate(key = gsub("Dbl-Cr Cormorant", "Double-Crested Cormorant" , key, fixed = T)) %>%
        mutate(key = gsub("Mallard-Wild", "Mallard" , key, fixed = T)) %>%
        mutate(key = gsub("Mallard-Feral", "Mallard" , key, fixed = T)) %>%
        mutate(key = gsub("Rock Pigeon", "Rock Dove" , key, fixed = T)) %>%
        mutate(key = gsub("Snow Goose-White", "Snow Goose" , key, fixed = T)) %>%
        mutate(key = gsub("Snow Goose-Blue", "Snow Goose" , key, fixed = T)) %>%

    mutate(key = gsub( "Black\\&", "Black-And-" , key, fixed = T)) %>%
    mutate(key = gsub( "Black&", "Black-And-" , key, fixed = T)) %>%
    mutate(key = gsub( "And-White-Warbler", "And-White Warbler" , key, fixed = T)) %>%

#  mutate(key =gsub( "Black\\&", "Black-And-", key,  fixed = T)) %>%
 mutate(key =gsub( "Black-Neccked Stilt", "Black-Necked Stilt", key,  fixed = T)) %>%
 mutate(key =gsub( "Brstd", "Breasted", key,  fixed = T)) %>%
 mutate(key =gsub( "Brown Crested", "Brown-Crested", key,  fixed = T)) %>%

 mutate(key =gsub( "Easterntowhee", "Eastern Towhee", key,  fixed = T)) %>%
 mutate(key =gsub( "Eur. Starling", "European Starling", key,  fixed = T)) %>%
 mutate(key =gsub( "Eur. Collared Dove", "Eurasian Collared-Dove", key,  fixed = T)) %>%
 mutate(key =gsub( "Eurasian Collared Dove", "Eurasian Collared-Dove", key,  fixed = T)) %>%


 mutate(key =gsub( "Dbl-Cr Cormorant", "Double-Crested Cormorant", key,  fixed = T)) %>%
 mutate(key =gsub( "Double Crested Cormorant", "Double-Crested Cormorant", key,  fixed = T)) %>%

 mutate(key =gsub( "Harris", "Harris's", key,  fixed = T)) %>%
 mutate(key =gsub( "H'bird", "Hummingbird", key,  fixed = T)) %>%

 mutate(key =gsub( "Le Conte's", "Leconte's", key,  fixed = T)) %>%

 mutate(key =gsub( "Mallard-Wild", "Mallard", key,  fixed = T)) %>%
 mutate(key =gsub( "N. Rough", "Northern Rough", key,  fixed = T)) %>%

 mutate(key =gsub( "Red's", "Red S", key,  fixed = T)) %>%

 mutate(key =gsub( "Selasphorus Sp.", "Hummingbird Sp.", key,  fixed = T)) %>%
 mutate(key =gsub( "Sharp'shinned Hawk", "Sharp-Shinned Hawk", key,  fixed = T)) %>%

 mutate(key =gsub( "Thoated", "Throated", key,  fixed = T)) %>%

 mutate(key =gsub( "Whip-Poor-Will", "Eastern Whip-Poor-Will", key,  fixed = T)) %>%
 mutate(key =gsub( "Woodp.", "Woodpecker", key,  fixed = T)) %>%
 mutate(key =gsub( "White Winged Dove", "White-Winged Dove", key,  fixed = T)) %>%
 mutate(key =gsub( "Whstling", "Whistling", key,  fixed = T))


# Add the species counts
# Recast the data and add up snow geese counts
df <-df %>%   group_by(year, key) %>%
    mutate(value =  sum(as.integer(value))) %>%
    distinct(year, key, value, .keep_all = T)

if(return.wide){
    df <- df %>%
        spread( key, value, fill=0)
}


# Return new names
return(df)

}
