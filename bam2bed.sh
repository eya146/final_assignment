#!/bin/bash

input_bam="$1"
output_directory="$2"

bam_filename=$(basename "$input_bam")
echo "Input BAM file: $input_bam"  
echo "Output directory: $output_dir"  

mkdir -p  "$output_directory"

bed_file="${bam_filename%.bam}.bed"
filtered="${bam_filename%.bam}_chr1.bed"

# Activate Conda and Mamba
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh


mamba create -n bam2bed bedtools -y
eval "$(mamba shell hook --shell bash)"
mamba activate bam2bed

# Convert BAM to BED
echo "Converting BAM to BED..."
bedtools bamtobed -i "$input_bam" > "$output_directory/$bed_file"

# Filter for chr1
echo "Filtering for chr1..."
grep -P  "^Chr1\t" "$output_directory/$bed_file" > "$output_directory/$filtered"

# Count lines in filtered file
echo "Counting lines in filtered BED file..."
wc -l "$output_directory/$filtered" > "$output_directory/bam2bed_number_of_rows.txt"

echo "Script completed successfully. Evangelia Sklaveniti"

