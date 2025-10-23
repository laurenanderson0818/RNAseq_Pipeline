#!/usr/bin/env nextflow

process VERSE {
    label 'process_medium'
    container 'ghcr.io/bf528/verse:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(name), path(bam)
    path(gtf)

    output:
    tuple val(name), path("*.exon.txt"), emit: counts

    script:
    """
    verse -S -a $gtf -o ${name}.exon.txt $bam
    """

}