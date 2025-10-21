#!/usr/bin/env nextflow

process MULTIQC {
    label 'process_low'
    container 'ghcr.io/bf528/multiqc:latest'
    publishDir outdir

    input:
    path('*')

    output:
    multiqc_report.html

    shell:
    """
    multiqc -f
    """

    stub:
    """

    """

}