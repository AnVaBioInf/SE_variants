#!/bin/bash

# Создаем файл со ссылками на загрузку vcf файлов выбранных id
awk '{print "https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20190425_NYGC_GATK/raw_calls_updated/" $1 ".haplotypeCalls.er.raw.vcf.gz"}' samples_meta_male_eur_100_1000Genomes30xGRCh38.csv > download_links_vcf_1000Genomes30xGRCh38.csv

# downloading vcf files
mkdir vcf
cd vcf
wget -i ../download_links_vcf_1000Genomes30xGRCh38.csv
