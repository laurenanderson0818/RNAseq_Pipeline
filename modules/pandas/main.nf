#!/usr/bin/env nextflow

process PANDAS {
    label 'process_medium'
    container 'ghcr.io/bf528/pandas:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    path(count_files)
    path(merge_script)

    output:
    path("merged_counts.csv")

    script:
    """
    python $merge_script -i ${count_files.join(' ')} -o merged_counts.csv
    """

}