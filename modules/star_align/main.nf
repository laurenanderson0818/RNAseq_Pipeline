#!/usr/bin/env nextflow

process ALIGN {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'

    input:
    tuple val(sample_id), path(reads)
    path(index)

    output:
    tuple val(sample_id), path("${sample_id}.Aligned.out.bam"), emit: bam
    tuple val(sample_id), path("${sample_id}.Log.final.out"), emit: log


    shell:
    """
    STAR --runThreadN $task.cpus --genomeDir $index --readFilesIn ${reads.join(' ')} --readFilesCommand zcat --outFileNamePrefix ${sample_id}. --outSAMtype BAM Unsorted 2> ${sample_id}.Log.final.out
    """

    stub:
    """
    touch ${sample_id}.Aligned.out.bam
    touch ${sample_id}.Log.final.out
    """

}