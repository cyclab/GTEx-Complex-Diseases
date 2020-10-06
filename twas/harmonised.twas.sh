#!/bin/bash
cd /home/pclam/tools/twas/

dataDir=/NAS_lab/pclam/gwas
resDir=/home/pclam/tools/twas/results

for data in af
do
  #mkdir ${resDir}/${data}
  
  for t in Adipose_Visceral_Omentum Artery_Tibial Brain_Caudate_basal_ganglia Brain_Spinal_cord_cervical_c-1
  do
    python MetaXcan/software/SPrediXcan.py \
      --keep_non_rsid \
    	--model_db_path data/models/enet/elastic_net_models/en_${t}.db \
    	--covariance data/models/enet/elastic_net_models/en_${t}.txt.gz \
      --gwas_file ${dataDir}/${data}/nielsen-thorolfsdottir-willer-NG2018-AFib-gwas-summary-statistics.tbl \
    	--snp_column rs_dbSNP147 \
    	--effect_allele_column A2 \
    	--non_effect_allele_column A1 \
    	--beta_column Effect_A2 \
    	--pvalue_column Pvalue \
    	--output_file ${resDir}/${data}/${data}.en.${t}.csv
  done
done