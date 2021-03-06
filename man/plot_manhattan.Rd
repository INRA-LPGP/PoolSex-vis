% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_manhattan.R
\name{plot_manhattan}
\alias{plot_manhattan}
\title{Plot manhattan}
\usage{
plot_manhattan(
  contig_lengths_file_path,
  prefix = NULL,
  window_fst_file_path = NULL,
  position_fst_file_path = NULL,
  window_snps_file_path = NULL,
  position_snps_file_path = NULL,
  depth_file_path = NULL,
  chromosomes_names_file_path = NULL,
  output.file = NULL,
  width = 14,
  height = 8,
  dpi = 300,
  track = "window_fst",
  lg.numbers = FALSE,
  point.size = 0.5,
  point.palette = c("dodgerblue3", "darkgoldenrod2"),
  background.palette = c("grey85", "grey100"),
  depth.type = "absolute",
  min.depth = 10
)
}
\arguments{
\item{contig_lengths_file_path}{Path to a contig lengths file.}

\item{prefix}{Prefix (including full path) to a complete dataset. If prefix is specified, it will be override individual file specifications
such as "window_fst_file_path" (default NULL).}

\item{window_fst_file_path}{Path to a FST window output file (default NULL).}

\item{position_fst_file_path}{Path to a FST positions output file (default NULL).}

\item{window_snps_file_path}{Path to a SNPs window output file (default NULL).}

\item{position_snps_file_path}{Path to a SNPs positions output file (default NULL).}

\item{depth_file_path}{Path to a depth output file (default NULL).}

\item{chromosomes_names_file_path}{Path to a contig names file (default NULL).}

\item{output.file}{Path to an output file in PNG format. If NULL, the plot will be drawn in the default graphic device (default: NULL).}

\item{width}{Width of the output file if specified, in inches (default: 14).}

\item{height}{Height of the output file if specified, in inches (default: 8).}

\item{dpi}{Resolution of the output file if specified, in dpi (default: 300).}

\item{track}{Track to be plotted. Possible values are "position_fst", "window_fst", "window_snp_males", "window_snp_females", "depth_males", "depth_females"
(default: "window_fst").}

\item{lg.numbers}{If TRUE, chromosomes / LGs will be labeled with numbers instead of names to increase readability (default: FALSE).}

\item{point.size}{Size of a point in the plot (default 0.5)}

\item{point.palette}{Color palette for the dots (default c("dodgerblue3", "darkgoldenrod2"))}

\item{background.palette}{Color palette for the background (default c("grey85", "grey100"))}

\item{depth.type}{Type of depth to be plotted, either "absolute" or "relative" (default: "absolute").}

\item{min.depth}{Minimum depth to compute depth ratio.
The ratio for positions with depth lower than this value in either sex will be 1 (default: 10).}
}
\description{
Generate a manhattan plot for a specific track from the results of PSASS.
}
\examples{

c_length <- "genome.fasta.fai"
c_names <- "names.tsv"
prefix <- "psass"
plot_manhattan(c_length, prefix=prefix, chromosomes_names_file_path = c_names, lg.numbers = TRUE)
}
