#!/usr/bin/env nextflow

include {FASTQC} from './modules/fastqc'
include {INDEX} from './modules/star_index'
include {PARSE_GTF} from './modules/parse_gtf'


workflow {
    
    Channel.fromFilePairs(params.reads).transpose().set{ fastqc_ch }
    Channel.fromFilePairs(params.reads).set { align_ch }

    
    PARSE_GTF(params.gtf)
    FASTQC(fastqc_ch)
    INDEX(params.genome, params.gtf)


}
