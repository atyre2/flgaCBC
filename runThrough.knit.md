---
title: "flgaCBC"
author: "Burnett, JL"
date: "February 20, 2019"
output: pdf_document
---

```r
## SPECIES TO INCLUDE
# You can count hummingbird sp, Archilochus sp., waterthrush sp., Empidonax sp. as Neotropical migrants,   Crow sp. as urban adapters, accipiter sp. as feeder adapters. I'd say ignore the rest.   
```







## FLGA CBC

![Annual effort and species richness for the FLGA CBC circle. Dashed line indicates year we begin analyses.](runThrough_files/figure-latex/effortPlots-1.pdf) 

The count format (broken up into 11 teams and all day counts) was instituted in 1972, so i think that would be a good time to begin. Therefore, we analze data from 1972 to 2018.


## Species groups

\begin{longtable}{llllllllllll}
\caption{\label{tab:sppGroupTab}Species groups for analysis}\\
\toprule
species & Neotropical migrants & Short-distance migrants & Locally endemic & Widespread declining & Non-native & N. FL wintering center & DDT-vics & Sweetwater & Urban adapters & Ag-loss vics & Feeder birds\\
\midrule
American Bittern &  &  &  &  &  &  &  & X &  &  & \\
American Crow &  &  &  &  &  & X &  &  & X &  & X\\
American Goldfinch &  &  &  &  &  & X &  &  &  &  & X\\
American Kestrel &  &  &  &  &  &  &  &  &  & X & \\
American Pipit &  &  &  &  &  &  &  &  &  & X & \\
\addlinespace
American Redstart & X &  &  &  &  &  &  &  &  &  & \\
American Robin &  &  &  &  &  & X &  &  &  &  & \\
American Woodcock &  & X &  &  &  &  &  &  &  &  & \\
Anhinga &  &  &  &  &  &  &  & X &  &  & \\
Ash Throated Flycatcher & X &  &  &  &  &  &  &  &  &  & \\
\addlinespace
Bachman's Sparrow &  &  & X &  &  &  &  &  &  &  & \\
Bald Eagle &  &  &  &  &  &  & X &  &  &  & \\
Baltimore Oriole & X &  &  &  &  &  &  &  &  &  & X\\
Barn Owl &  &  &  &  &  &  &  &  & X & X & \\
Belted Kingfisher &  &  &  &  &  & X &  &  &  &  & \\
\addlinespace
Black-And-White-Warbler &  &  &  &  &  & X &  &  &  &  & \\
Black-And-White Warbler & X &  &  &  &  &  &  &  &  &  & \\
Black-Bellied Whistling-Duck &  &  &  &  & X &  &  &  & X &  & \\
Black-Chinned Hummingbird & X &  &  &  &  &  &  &  &  &  & \\
Black-Crowned Night-Heron &  &  &  &  &  &  &  & X &  &  & \\
\addlinespace
Black-Headed Grosbeak & X &  &  &  &  &  &  &  &  &  & \\
Black-Throated Blue Warbler & X &  &  &  &  &  &  &  &  &  & \\
Black Vulture &  &  &  &  &  &  &  &  & X &  & \\
Blue-Gray Gnatcatcher &  &  &  &  &  & X &  &  &  &  & \\
Blue-Headed Vireo &  &  &  &  &  & X &  &  &  &  & \\
\addlinespace
Blue-Winged Teal &  &  &  &  &  &  &  & X &  &  & \\
Blue Jay &  &  &  &  &  & X &  &  & X &  & X\\
Boat-Tailed Grackle &  &  &  &  &  &  &  &  & X & X & \\
Brown-Headed Cowbird &  &  &  &  &  & X &  &  & X &  & X\\
Brown-Headed Nuthatch &  &  & X &  &  &  &  &  &  &  & \\
\addlinespace
Brown Creeper &  & X &  &  &  &  &  &  &  &  & \\
Brown Thrasher &  &  &  & X &  & X &  &  & X & X & \\
Canada Goose &  &  &  &  &  &  &  &  & X &  & \\
Cape May Warbler & X &  &  &  &  &  &  &  &  &  & \\
Carolina Chickadee &  &  &  &  &  & X &  &  & X &  & X\\
\addlinespace
Carolina Wren &  &  &  &  &  & X &  &  & X &  & X\\
Chestnut-Sided Warbler & X &  &  &  &  &  &  &  &  &  & \\
Chipping Sparrow &  &  &  &  &  & X &  &  &  &  & X\\
Common Grackle &  & X &  &  &  &  &  &  & X & X & \\
Common Ground-Dove &  &  &  & X &  &  &  &  &  & X & \\
\addlinespace
Common Yellowthroat &  &  &  &  &  & X &  &  &  &  & \\
Cooper's Hawk &  &  &  &  &  &  & X &  &  &  & X\\
Dark-Eyed Junco &  & X &  &  &  &  &  &  &  &  & \\
Dickcissel & X &  &  &  &  &  &  &  &  &  & \\
Double-Crested Cormorant &  &  &  &  &  &  & X & X &  &  & \\
\addlinespace
Downy Woodpecker &  &  &  &  &  & X &  &  &  &  & \\
Eastern Bluebird &  &  &  &  &  & X &  &  &  & X & \\
Eastern Meadowlark &  &  &  & X &  &  &  &  &  & X & \\
Eastern Phoebe &  &  &  &  &  & X &  &  &  & X & \\
Eastern Screech-Owl &  &  &  &  &  &  &  &  & X &  & \\
\addlinespace
Eastern Towhee &  & X &  &  &  &  &  &  &  &  & \\
Eastern Whip-Poor-Will & X &  &  &  &  &  &  &  &  &  & \\
Eurasian Collared-Dove &  &  &  &  & X &  &  &  & X &  & \\
European Starling &  &  &  &  & X &  &  &  & X &  & \\
Field Sparrow &  &  &  & X &  &  &  &  &  & X & \\
\addlinespace
Fish Crow &  &  &  &  &  & X &  &  & X &  & \\
Fox Sparrow &  & X &  &  &  &  &  &  &  &  & \\
Glossy Ibis &  &  &  &  &  &  &  & X &  &  & \\
Golden-Crowned Kinglet &  & X &  &  &  &  &  &  &  &  & \\
Grasshopper Sparrow &  &  &  & X &  &  &  &  &  &  & \\
\addlinespace
Gray Catbird &  &  &  &  &  & X &  &  &  &  & \\
Great-Crested Flycatcher & X &  &  &  &  &  &  &  &  &  & \\
Great-Horned Owl &  &  &  &  &  &  &  &  & X &  & \\
Great Blue Heron &  &  &  &  &  &  &  & X &  &  & \\
Green Heron &  &  &  &  &  &  &  & X &  &  & \\
\addlinespace
Henslow's Sparrow &  &  &  & X &  &  &  &  &  &  & \\
Hermit Thrush &  & X &  &  &  &  &  &  &  &  & \\
Hooded Merganser &  &  &  &  &  &  &  &  & X &  & \\
Hooded Warbler & X &  &  &  &  &  &  &  &  &  & \\
House Finch &  &  &  &  &  &  &  &  & X &  & X\\
\addlinespace
House Sparrow &  &  &  &  & X &  &  &  & X & X & X\\
House Wren &  &  &  &  &  & X &  &  & X &  & \\
Indigo Bunting & X &  &  &  &  &  &  &  &  &  & X\\
Kentucky Warbler & X &  &  &  &  &  &  &  &  &  & \\
Killdeer &  &  &  &  &  & X &  &  &  & X & \\
\addlinespace
King Rail &  &  &  &  &  &  &  & X &  &  & \\
Least Bittern &  &  &  &  &  &  &  & X &  &  & \\
Limpkin &  &  &  &  &  &  &  & X &  &  & \\
Little Blue Heron &  &  &  &  &  &  &  & X &  &  & \\
Loggerhead Shrike &  &  &  & X &  &  &  &  &  & X & \\
\addlinespace
Louisiana Waterthrush & X &  &  &  &  &  &  &  &  &  & \\
Magnolia Warbler & X &  &  &  &  &  &  &  &  &  & \\
Mallard &  &  &  &  & X &  &  &  & X &  & \\
Mallard-Feral &  &  &  &  & X &  &  &  & X &  & \\
Marsh Wren &  &  &  &  &  &  &  & X &  &  & \\
\addlinespace
Merlin &  &  &  &  &  &  & X &  &  &  & \\
Mourning Dove &  &  &  &  &  & X &  &  &  & X & X\\
Nashville Warbler & X &  &  &  &  &  &  &  &  &  & \\
Northern Bobwhite &  &  &  & X &  &  &  &  &  &  & \\
Northern Cardinal &  &  &  &  &  & X &  &  & X &  & X\\
\addlinespace
Northern Harrier &  & X &  &  &  &  &  &  &  & X & \\
Northern Mockingbird &  &  &  &  &  &  &  &  & X & X & \\
Northern MockingBird &  &  &  &  &  & X &  &  &  &  & \\
Northern Parula & X &  &  &  &  &  &  &  &  &  & \\
Northern Waterthrush & X &  &  &  &  &  &  &  &  &  & \\
\addlinespace
Orange-Crowned Warbler &  &  &  &  &  & X &  &  &  &  & \\
Osprey &  &  &  &  &  &  & X &  &  &  & \\
Ovenbird & X &  &  &  &  &  &  &  &  &  & \\
Painted Bunting & X &  &  &  &  &  &  &  &  &  & X\\
Palm Warbler &  &  &  &  &  & X &  &  &  &  & \\
\addlinespace
Peregrine Falcon &  &  &  &  &  &  & X &  &  &  & \\
Pileated Woodpecker &  &  &  &  &  &  &  &  & X &  & \\
Pine Siskin &  & X &  &  &  &  &  &  &  &  & X\\
Pine Warbler &  &  &  &  &  & X &  &  &  &  & \\
Prairie Warbler & X &  &  &  &  &  &  &  &  &  & \\
\addlinespace
Purple Finch &  & X &  &  &  &  &  &  &  &  & \\
Purple Gallinule &  &  &  &  &  &  &  & X &  &  & \\
Red-Bellied Woodpecker &  &  &  &  &  & X &  &  &  &  & X\\
Red-Breasted Nuthatch &  & X &  &  &  &  &  &  &  &  & X\\
Red-Cockaded Woodpecker &  &  & X &  &  &  &  &  &  &  & \\
\addlinespace
Red-Headed Woodpecker &  &  &  & X &  &  &  &  &  &  & \\
Red-Shouldered Hawk &  &  &  &  &  &  & X &  & X &  & \\
Red-Tailed Hawk &  &  &  &  &  &  &  &  &  & X & \\
Red-Winged Blackbird &  & X &  &  &  &  &  &  &  & X & \\
Ring-Billed Gull &  &  &  &  &  &  &  &  & X &  & X\\
\addlinespace
Rock Dove &  &  &  &  & X &  &  &  & X &  & \\
Rose-Breasted Grosbeak & X &  &  &  &  &  &  &  &  &  & \\
Ruby-Throated Hummingbird & X &  &  &  &  &  &  &  &  &  & \\
Ruby Crowned Kinglet &  &  &  &  &  & X &  &  &  &  & \\
Rufous Hummingbird & X &  &  &  &  &  &  &  &  &  & \\
\addlinespace
Rusty Blackbird &  & X &  &  &  &  &  &  &  &  & \\
Sandhill Crane &  & X &  &  &  &  &  &  &  &  & \\
Sedge Wren &  &  &  &  &  & X &  &  &  &  & \\
Sharp-Shinned Hawk &  & X &  &  &  &  & X &  &  &  & X\\
Snail Kite &  &  &  &  &  &  &  & X &  &  & \\
\addlinespace
Song Sparrow &  & X &  &  &  &  &  &  &  &  & \\
Sora &  &  &  &  &  &  &  & X &  &  & \\
Summer Tanager & X &  &  &  &  &  &  &  &  &  & \\
Swamp Sparrow &  &  &  &  &  & X &  &  &  &  & \\
Tricolored Heron &  &  &  &  &  &  &  & X &  &  & \\
\addlinespace
Tufted Titmouse &  &  &  &  &  & X &  &  & X &  & X\\
Turkey Vulture &  &  &  &  &  &  &  &  & X &  & \\
Vaux's Swift & X &  &  &  &  &  &  &  &  &  & \\
Vermilion Flycatcher & X &  &  &  &  &  &  &  &  &  & \\
Vesper Sparrow &  & X &  &  &  &  &  &  &  & X & \\
\addlinespace
Virginia Rail &  &  &  &  &  &  &  & X &  &  & \\
Western Tanager & X &  &  &  &  &  &  &  &  &  & \\
White-Crowned Sparrow &  & X &  &  &  &  &  &  &  &  & \\
White-Eyed Vireo &  &  &  &  &  & X &  &  &  &  & \\
White-Faced Ibis &  &  &  &  &  &  &  & X &  &  & \\
\addlinespace
White-Throated Sparrow &  & X &  &  &  &  &  &  &  &  & \\
White Ibis &  &  &  &  &  &  &  & X & X &  & \\
Wilson's Warbler & X &  &  &  &  &  &  &  &  &  & \\
Winter Wren &  & X &  &  &  &  &  &  &  &  & \\
Wood Duck &  &  &  &  &  &  &  &  & X &  & \\
\addlinespace
Wood Stork &  &  &  &  &  &  &  & X &  &  & \\
Wood Thrush & X &  &  &  &  &  &  &  &  &  & \\
Worm-Eating Warbler & X &  &  &  &  &  &  &  &  &  & \\
Yellow-Bellied Sapsucker &  &  &  &  &  & X &  &  &  &  & \\
Yellow-Crowned Night-Heron &  &  &  &  &  &  &  & X &  &  & \\
\addlinespace
Yellow-Rumped Warbler &  &  &  &  &  & X &  &  &  &  & \\
Yellow-Throated Vireo & X &  &  &  &  &  &  &  &  &  & \\
Yellow-Throated Warbler &  &  &  &  &  & X &  &  &  &  & X\\
Yellow Breasted Chat & X &  &  &  &  &  &  &  &  &  & \\
\bottomrule
\end{longtable}

