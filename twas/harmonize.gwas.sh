#!/bin/bash

GWAS_TOOLS=/NAS_lab/pclam/gwas/summary-gwas-imputation/src
DATA=/NAS_lab/pclam/gwas
OUTPUT=/NAS_lab/pclam/gwas/summary_stats/harmonized_gwas

python $GWAS_TOOLS/gwas_parsing.py \
	-gwas_file $DATA/summary_stats/cytokines/CRP.new.txt \
	-liftover $DATA/liftover/hg19ToHg38.over.chain.gz \
	-snp_reference_metadata $DATA/snp_data/gtex_v8_eur_filtered_maf0.01_monoallelic_variants.txt.gz METADATA \
	-output_column_map SNP variant_id \
	-output_column_map ALLELE0 non_effect_allele \
	-output_column_map ALLELE1 effect_allele \
	-output_column_map BETA effect_size \
	-output_column_map SE standard_error \
	-output_column_map P pvalue \
	-output_column_map A1FREQ frequency \
	-output_column_map CHR chromosome \
	-output_column_map BP position \
  --chromosome_format \
	--insert_value sample_size 418642 \
	-output $OUTPUT/crp.harmonised.txt
