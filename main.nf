#!/usr/bin/env nextflow

include {FASTQC} from './modules/fastqc'
include {INDEX} from './modules/star_index'
include {PARSE_GTF} from './modules/parse_gtf'
include {ALIGN} from './modules/star_align'
include {MULTIQC} from './modules/multiqc'
include {VERSE} from './modules/verse'
include {PANDAS} from './modules/pandas'


workflow {
    
    Channel.fromFilePairs(params.reads).transpose().set{ fastqc_ch }
    Channel.fromFilePairs(params.reads).set { align_ch }
    
    PARSE_GTF(params.gtf)
    FASTQC(fastqc_ch)
    INDEX(params.genome, params.gtf)
    ALIGN(align_ch, INDEX.out)

    FASTQC.out.zip.map{ it[1] }.mix(ALIGN.out.log.map{ it[1] }).collect().set{ multiqc_ch }

    MULTIQC(multiqc_ch)
    VERSE(ALIGN.out.bam, params.gtf)
    VERSE.out.map{ name, file -> file }.collect().set { counts_ch }
    PANDAS(counts_ch, file('bin/merge_counts.py'))

}
