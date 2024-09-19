#!/bin/bash

mkdir ~/project/variants/vcf_1000_genomes_filtered
mkdir ~/project/variants/vcf_1000_genomes_filtered/vcf_1000_genomes_filtered_se
mkdir ~/project/variants/vcf_1000_genomes_filteredvcf_1000_genomes_filtered_e_no_se

cd ~/project/variants/vcf_1000_genomes/
vcf_files=(*)
echo ${vcf_files[@]}

# intersecting vcf and bed files
# leaving only mutations in SE enhancer elements (taken from ENCODE)
for i in "${vcf_files[@]}"; \
do \
~/programs/bedtools2/bin/bedtools intersect -wa -wb \
-a ~/project/variants/vcf_1000_genomes/$i \
-b ~/project/se/se_encode_e_classified.bed > ~/project/variants/vcf_1000_genomes_filtered/vcf_1000_genomes_filtered_se/${i%.vcf*}_filtered_se.vcf; \
done;

# leaving only mutations in typical enhancers (taken from ENCODE) (SE enhancer elements were excluded)
for i in "${vcf_files[@]}"; \
do \
~/programs/bedtools2/bin/bedtools intersect  -wa -wb \
-a ~/project/variants/vcf_1000_genomes/$i \
-b ~/project/enhancers/ENCFF900YFA_classified_noSE.bed > \
~/project/variants/vcf_1000_genomes_filtered/vcf_1000_genomes_filtered_e_no_se/${i%.vcf*}_filtered_e_no_se.vcf.gz; \
done;
