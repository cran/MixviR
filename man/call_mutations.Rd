% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/id_mutations.R
\name{call_mutations}
\alias{call_mutations}
\title{Identify Variants From A Potentially Mixed Sample}
\usage{
call_mutations(
  sample.dir = NULL,
  fasta.genome,
  bed,
  reference = "custom",
  min.alt.freq = 0.01,
  name.sep = NULL,
  write.all.targets = FALSE,
  lineage.muts = NULL,
  genetic.code.num = "1",
  out.cols = c("SAMP_NAME", "CHR", "POS", "GENE", "ALT_ID", "AF", "DP"),
  write.mut.table = FALSE,
  outfile.name = "sample_mutations.csv",
  indel.format = "Fwd",
  csv.infiles = FALSE
)
}
\arguments{
\item{sample.dir}{\strong{Required} Path to directory containing vcf files for each sample to be analyzed. VCF's need to contain "DP" and "AD" flags in the FORMAT field. This directory should not contain any other files.}

\item{fasta.genome}{Path to fasta formatted reference genome file. \strong{Required unless \emph{reference} is defined}.}

\item{bed}{Path to bed file defining features of interest (open reading frames to translate). Should be tab delimited and have 6 columns (no column names): chr, start, end, feature_name, score (not used), strand. \strong{Required unless \emph{reference} is defined}. See example at https://github.com/mikesovic/MixviR/blob/main/raw_files/sars_cov2_genes.bed.}

\item{reference}{Optional character defining a pre-constructed MixviR reference (created with `create_ref()``). "Wuhan" uses pre-generated Sars-Cov2 ref genome. Otherwise, \emph{fasta.genome} and \emph{bed} are required to generate MixviR formatted reference as part of the analysis.}

\item{min.alt.freq}{Minimum frequency (0-1) for retaining alternate alleles. Default = 0.01. Extremely low values (i.e. zero) are not recommended here - see vignette for details.}

\item{name.sep}{Optional character in input file names that separates the unique sample identifier (characters preceeding the separator) from any additional text. Only text preceeding the first instance of the character will be retained and used as the sample name.}

\item{write.all.targets}{Logical that, if TRUE, reports sequencing depths for genomic positions associated with mutations of interest that are not observed in the sample, in addition to all mutations observed in the sample. If TRUE, requires columns "Chr" and "Pos" to be included in the \emph{lineage.muts} file. Default FALSE.}

\item{lineage.muts}{Path to optional csv file defining target mutations and their underlying genomic positions. Requires cols "Gene", "Mutation", "Lineage", "Chr" and "Pos". This is used to report the sequencing depths for relevant positions when the mutation of interest is not observed in the sample. See \emph{write.all.targets}. This file is also used in \code{explore_mutations()}, where the "Chr" and "Pos" columns are optional. Only necessary here in conjunction with \emph{write.all.targets}.}

\item{genetic.code.num}{Number (character) associated with the genetic code to be used for translation. Details can be found at https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi.}

\item{out.cols}{Character vector with names of columns to be returned. Choose from: CHR, POS, REF_BASE, GENE, STRAND, REF_CODON, REF_AA, GENE_AA_POS, REF_IDENT, REF, ALT, AF, ALT_COUNT, SAMP_CODON, SAMP_AA, ALT_ID, DP, SAMP_NAME, TYPE. The default columns SAMP_NAME, CHR, POS, ALT_ID, AF, DP must be included to run explore_mutations().}

\item{write.mut.table}{Logical indicating whether to write the 'samp_mutations' data frame (see "Value" below) to a text file (csv). Default = FALSE. See \emph{outfile.name}.}

\item{outfile.name}{Path to file where (csv) output will be written if \emph{write.mut.table} is TRUE. Default: "sample_mutations.csv" (written to working directory)}

\item{indel.format}{Defines the naming convention for indels. Default is "Fwd", meaning the name would look like S_del144/144. "Rev" switches this to S_144/144del.}

\item{csv.infiles}{Logical to indicate whether files in \emph{sample.dir} directory are in vcf or csv format. All files must be of the same format. If csv, they must contain columns named: "CHR"    "POS"    "REF"    "ALT"    "DP"    "ALT_COUNT". See the `batch_vcf_to_mixvir()`` function to convert vcfs to csv format). Default is FALSE (input is in vcf format). This exists primarily for legacy reasons.}
}
\value{
A data frame containing variants observed for each sample, positions of the underlying mutations, and other (customizable) information. This data frame can be saved as an object in the global environment and/or written to a file (see \emph{write.mut.table}), and in either case serves as input for the \emph{MixviR} functions \code{explore_mutations()} and \code{estimate_lineages()}.
}
\description{
Identify full set of amino acid/SNP/indel changes from one or more samples (includes changes based on both SNVs and indels). This is generally the first function run in a MixviR analysis.
}
\examples{
  
 ##For SARS-CoV-2 
 #call_mutations(sample.dir = system.file("extdata", "vcf", package = "MixviR"), 
 #                name.sep = "_", reference = "Wuhan") 
   
 ##OR if defining a custom reference, follow this pattern...  
 #genome<-"https://raw.githubusercontent.com/mikesovic/MixviR/main/raw_files/GCF_ASM985889v3.fa"
 #features<-"https://raw.githubusercontent.com/mikesovic/MixviR/main/raw_files/sars_cov2_genes.bed"
   
 #call_mutations(sample.dir = system.file("extdata", "vcf", package = "MixviR"), 
 #                name.sep = "_", 
 #                fasta.genome = genome,
 #                bed = features)
}
\keyword{mutation}
