#!/bin/bash

TOOL=/home/pclam/tools/twas/MetaXcan/software
MODELDIR=/home/pclam/tools/twas/data/models/elastic_net_models
GWASDIR=/NAS_lab/pclam/gwas/summary_stats/harmonized_gwas
RESDIER=/home/pclam/tools/twas/results/cytokines

for DATA in CRP IFNg IL6 MCP1
do
  mkdir $RESDIER/$DATA
  for t in Adipose_Visceral_Omentum Artery_Tibial Brain_Caudate_basal_ganglia Brain_Spinal_cord_cervical_c-1 Brain_Hypothalamus Brain_Putamen Whole_Blood
  do
    python $TOOL/SPrediXcan.py \
      --keep_non_rsid \
    	--model_db_path $MODELDIR/en_$t.db \
    	--covariance $MODELDIR/en_$t.txt.gz \
      --gwas_file $GWASDIR/$DATA.harmonised.txt.gz \
    	--snp_column variant_id \
    	--chromosome_column chromosome \
    	--position_column position \
    	--effect_allele_column effect_allele \
    	--non_effect_allele_column non_effect_allele \
    	--freq_column frequency \
    	--se_column standard_error \
    	--zscore_column zscore \
    	--beta_column effect_size \
    	--pvalue_column pvalue \
    	--output_file $RESDIER/$DATA/$DATA.en.$t.csv
  done
done
