#!/bin/bash

#$ -N review_db_5b_paired_VHVL_20260630
#$ -P roslin_jhammon2_bezos_methane
#$ -cwd
#$ -V
#$ -l h_rss=8G
#$ -pe sharedmem 2
#$ -l h_rt=12:00:00
#$ -m be
#$ -M smoon@ed.ac.uk


# # usage
# python3 5b_build_paired_vh_vl_database_v2_20260630.py \
#     --cluster_dir "$CLUSTERING_OUT_DIR" \
#     --light_dir   "$LIGHT_CHAIN_DIR" \
#     --summary_csv_pbmc   pbmc/overall_statistics_score_gold_silver3pts.csv \
#     --summary_csv_rln    rln/overall_statistics_score_gold_silver3pts.csv \
#     --summary_csv_spleen spleen/overall_statistics_score_gold_silver3pts.csv \
#     --output_dir review_databases

set -euo pipefail

# =========================================================
# Environment Setup
# =========================================================
module purge
module load anaconda

conda activate tools_env

# =========================================================
# Paths & Config
# =========================================================
ROOT_OUT_DIR="/exports/cmvm/eddie/eb/groups/jhammon2_bezos_methane/github/methane/main2025/PM03_CH4_10xVDJ_bos_BSP358/outs"
ROOT_SCR_DIR="/exports/cmvm/eddie/eb/groups/jhammon2_bezos_methane/github/methane/main2025/PM03_CH4_10xVDJ_bos_BSP358/scr"

CLUSTER_DIR="${ROOT_OUT_DIR}/3_clus_outs/3_cluster_extract_FullVH_cdr3_0.94_20260428/per_animal_tissue"
SCORE_DIR="${ROOT_OUT_DIR}/4_scoring_abs_outs_v4.6_20261008"
ALIGN_DIR="${ROOT_OUT_DIR}/5_align_outs_v5_xTissue_20261008"
LIGHT_DIR="${ALIGN_DIR}/5o_light_outs/per_animal_tissue/light_cluster_tables"

# Using the version defined in your paths block
SCRIPT="${ROOT_SCR_DIR}/05_align_scr/sub_align_scr/5b_build_paired_vh_vl_database_filtered_20260630.py"
OUTPUT_DIR="${ALIGN_DIR}/test_filtered_5b_review_paired_vhvl_csv"

mkdir -p "${OUTPUT_DIR}"

# =========================================================
# Execution
# =========================================================
echo "🚀 Running paired VH/VL database generation script..."

python3 "${SCRIPT}" \
    --summary_csv_pbmc   "${SCORE_DIR}/pbmc/4c_overall_statistics_score_gold_silver4pts.csv" \
    --summary_csv_rln    "${SCORE_DIR}/rln/4c_overall_statistics_score_gold_silver4pts.csv" \
    --summary_csv_spleen "${SCORE_DIR}/spleen/4c_overall_statistics_score_gold_silver4pts.csv" \
    --cluster_dir        "${CLUSTER_DIR}" \
    --light_dir          "${LIGHT_DIR}" \
    --output_dir         "${OUTPUT_DIR}"

echo "✅ Job completed successfully."
