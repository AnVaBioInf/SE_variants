#!/bin/bash

# filtering out unclassified enhancers
awk -F"\t" '$10!="Unclassified" {print $0}' ENCFF900YFA.bed > ENCFF900YFA_classified.bed

# SE annotation element-wise. Intersecting SEA and ENCODE .bed files, leaving only ECODE high H324K4 enhancers that intersected SE
~/programs/bedtools2/bin/bedtools intersect -wa -wb -a ~/project/enhancers/ENCFF900YFA_classified.bed \
-b ~/project/se/SE_only_cd14plus_monocyte_norownumb_SEA00101.bed > ~/project/se/se_encode_e_classified.bed 

# excluding SE from enhancer file
~/programs/bedtools2/bin/bedtools intersect -v -f 1.0 -a ~/project/enhancers/ENCFF900YFA_classified.bed \
-b ~/project/se/SE_only_cd14plus_monocyte_norownumb_SEA00101.bed > ~/project/enhancers/ENCFF900YFA_classified_noSE.bed

# statistics
# total number of high H3K27ac ENCODE predicted enhancer elements in SE
cat ~/project/se/se_encode_e_classified.bed | wc -l
# 31726

# total number of typical enhancers (not intersecting with SE)
cat ~/project/enhancers/ENCFF900YFA_classified_noSE.bed | wc -l
# 117966


# check -f!!!
# make sure, that all enhancers intersecting SE on whatever number of bases are not included in 
# enhancers that do not intersect SE
