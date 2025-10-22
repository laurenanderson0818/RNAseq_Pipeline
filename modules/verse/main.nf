#!/usr/bin/env nextflow

process VERSE {
    label 'process_high'
    container 'ghcr.io/bf528/verse:latest'

    input:
    tuple val(sample_id), path(bam_file)
    path gtf

    output:
    path "${sample_id}.exon.txt"

    shell:
    """
    verse -a $bam_file -g $gtf -S -o ${sample_id}.exon.txt
    """

    stub:
    """
    touch "${sample_id}.exon.txt"
    """

}