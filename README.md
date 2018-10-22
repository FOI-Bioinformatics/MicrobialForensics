# MicrobialForensics
A likelihood ratio-based approach for improved source attribution in microbial forensics
## data processing
### extract variants from vcf file
extract_variants_from_vcf_file.pl all_data.positions.snp.vcf > data_matrix_snp.txt
### calculate pairwise Euclidean disance between samples
calc_eucledian_dist.pl data_matrix_snp.txt > dist_snp.txt

## plots

