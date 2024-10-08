#!/bin/bash

# to get the download link for 1000 Genomes 30x on GRCh38 project metadata file
# Fo to 1000 Genomes 30x on GRCh38 website (https://www.internationalgenome.org/data-portal/data-collection/30x-grch38) 
# F12 key -> Network
# Download file locally, find it in Network, right click it and choose copy->copy as cURL

mkdir ~/project/variants && cd $_

# download samples metadata
curl 'https://www.internationalgenome.org/api/beta/sample/_search/igsr-1000%20genomes%2030x%20on%20grch38.tsv.tsv' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7,ar;q=0.6' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Cookie: _ga=GA1.1.1802283460.1724943721; data_notice_20180523=dismiss; _ga_CZMMSVPEPC=GS1.1.1725532584.18.0.1725532584.0.0.0' \
  -H 'Origin: https://www.internationalgenome.org' \
  -H 'Pragma: no-cache' \
  -H 'Referer: https://www.internationalgenome.org/data-portal/data-collection/30x-grch38' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Google Chrome";v="125", "Chromium";v="125", "Not.A/Brand";v="24"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  --data-raw 'json=%7B%22fields%22%3A%5B%22name%22%2C%22sex%22%2C%22biosampleId%22%2C%22populations.code%22%2C%22populations.name%22%2C%22populations.superpopulationCode%22%2C%22populations.superpopulationName%22%2C%22populations.elasticId%22%2C%22dataCollections.title%22%5D%2C%22column_names%22%3A%5B%22Sample+name%22%2C%22Sex%22%2C%22Biosample+ID%22%2C%22Population+code%22%2C%22Population+name%22%2C%22Superpopulation+code%22%2C%22Superpopulation+name%22%2C%22Population+elastic+ID%22%2C%22Data+collections%22%5D%2C%22query%22%3A%7B%22constant_score%22%3A%7B%22filter%22%3A%7B%22term%22%3A%7B%22dataCollections.title%22%3A%221000+Genomes+30x+on+GRCh38%22%7D%7D%7D%7D%7D' \
  > samples_meta_1000Genomes30xGRCh38.csv

# exploring the file
# number of records for target group (European males)
awk '$2=="male" && $6=="EUR" {print}' samples_meta_1000Genomes30xGRCh38.csv | wc -l
# 304

# representation of european subpopulations
awk '{count[$5]++} END {for (value in count) print value, count[value]}' samples_meta_male_eur_1000Genomes30xGRCh38.csv
# Finnish 36
# Iberian 79
# British,English 1
# CEPH 87
# Toscani 53
# Finnish,Finnish 2
# Iberian,Spanish 1
# British 45

# selecting 20 samples from each subpopulation, to make the sample balanced
# Finish subpopulation was excluded due to unique genetic variations, not representative of european population
# CEPH subpopulation was excluded due to lack of evidence for it to be of european ancestry (?)
awk '$2=="male" && $4=="TSI" {print $0}' samples_meta_1000Genomes30xGRCh38.csv | head -33  > samples_meta_male_eur_100_1000Genomes30xGRCh38.csv 
awk '$2=="male" && $4=="IBS" {print $0}' samples_meta_1000Genomes30xGRCh38.csv | head -33 >> samples_meta_male_eur_100_1000Genomes30xGRCh38.csv 
awk '$2=="male" && $4=="GBR" {print $0}' samples_meta_1000Genomes30xGRCh38.csv | head -34 >> samples_meta_male_eur_100_1000Genomes30xGRCh38.csv 
