#!/usr/bin/Rscript

## This script will extract the first names from a Sakai course grade file.  The
## output will be written to stdout.

## Example: $ Rscript 00_pull_first_names.R --file coursegradefile.csv

## This is useful when preparing for 00_Introduction/deck0.pdf.  Do

## $ Rscript 00_pull_first_names.R --file coursegradefile.csv > firstnames.csv

## Then open up firstnames.csv using a spreadsheet application and paste them
## into 00_CountFirstNames.ods to count the instances of the popular names.

## You can print off a copy of the silver-feature-*.png files in the figures
## folder and then use those on the doc came for your class.

## FOR COMMAND LINE...

library("getopt")

spec <- matrix(c(
    "file"     , "f", 1, "character", # The .csv course grade file from Sakai.
    "help"     , "h", 0, "logical"
    ), ncol=4, byrow=TRUE)

opt  = getopt(spec, opt=commandArgs(TRUE))

if ( !is.null(opt$help) || is.null(opt$file) ) {
    cat(getopt(spec, usage=TRUE))
    q(status=1)
}

## Example if you wanted to have a default value.
## if ( is.null(opt$file) ) opt$file       = "somefile.csv"

## THE ACTUAL SCRIPT...

if ( file.exists(opt$file) ) {

    csv        = read.csv(opt$file, header=TRUE)
    full.name  = as.character( csv$Student.Name )
    first.name = sapply( strsplit(full.name, split=", ") , function(x){x[2]})

    cat("First.Name", "\n", sep="")
    for(name in first.name)
        cat(name, "\n", sep="")
    
}
