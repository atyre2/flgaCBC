#' @title Fix species names on CBC list to correspond with NACC species list
#' @param df A data frame with header that includes all species (common names).
#' @export

editNames <- function(df){

# Let's work with the column names
edit.names <- names(df)

# Force to title case
edit.names <- str_to_title(edit.names)

# Trim whitespace
edit.names <- trimws(edit.names, which = "left")
edit.names <- trimws(edit.names, which = "right")

edit.names <- gsub("Bald Eagle Ad.", "Bald Eagle", edit.names)
edit.names <- gsub("Bald Eagle Imm.", "Bald Eagle", edit.names)
edit.names <- gsub("Bald Eagle Unk.", "Bald Eagle", edit.names)

edit.names <- gsub("Black\\&", "Black-And-", edit.names)
edit.names <- gsub("Black-Neccked Stilt", "Black-Necked Stilt", edit.names)
edit.names <- gsub("Brstd", "Breasted", edit.names)
edit.names <- gsub("Brown Crested", "Brown-Crested", edit.names, fixed =T)

edit.names <- gsub("Easterntowhee", "Eastern Towhee", edit.names)
edit.names <- gsub("Eur. Starling", "European Starling", edit.names, fixed=T)
edit.names <- gsub("Eur. Collared Dove", "Eurasian Collared-Dove", edit.names, fixed=T)


edit.names <- gsub("Dbl-Cr Crested Cormorant", "Double-Crested Cormorant", edit.names, fixed=T)
edit.names <- gsub("Double Crested Cormorant", "Double-Crested Cormorant", edit.names)

edit.names <- gsub("Harris", "Harris's", edit.names, fixed =T)
edit.names <- gsub("H'bird", "Hummingbird", edit.names, fixed =T)

edit.names <- gsub("Le Conte's", "Leconte's", edit.names, fixed =T)

edit.names <- gsub("Mallard-Wild", "Mallard", edit.names)
edit.names <- gsub("N. Rough", "Northern Rough", edit.names, fixed =T)

edit.names <- gsub("Red's", "Red S", edit.names)

edit.names <- gsub("Selasphorus Sp.", "Hummingbird Sp.", edit.names)
edit.names <- gsub("Sharp'shinned Hawk", "Sharp-Shinned Hawk", edit.names)

edit.names <- gsub("Thoated", "Throated", edit.names)

edit.names <- gsub("Whip-Poor-Will", "Eastern Whip-Poor-Will", edit.names, fixed =T)
edit.names <- gsub("Woodp.", "Woodpecker", edit.names, fixed =T)

#@ NOT WORKING FOR SOME REASONs
edit.names <- gsub("Whstling", "Whistling", edit.names)


# Return new names
return(edit.names)

}
