#!/usr/bin/env Rscript
library(dplyr)
library(ggplot2)
library(viridis)

# Read arguments
args = commandArgs(trailingOnly=TRUE)

if (length(args) != 2 ) {
  stop('Usage: check.R WORLOAD OUTPUTPDF')
}

# Functions
alloc_size <- function(alloc_str){
    return(length(unlist(strsplit(alloc_str, " "))))
}

# Script
data = read.csv(args[1])
data = data %>%
    rowwise() %>%
    mutate(alloc_length = alloc_size(toString(allocated_processors))) %>%
    mutate(add_diff = alloc_length - requested_number_of_processors,
           mul_diff = alloc_length / requested_number_of_processors)

hlines = data.frame("value"=c(0, 1),
                    "name"=c("add_diff", "mul_diff"))

ggplot(data) +
    geom_point(aes(x=job_id, y=add_diff, color="add_diff")) +
    geom_point(aes(x=job_id, y=mul_diff, color="mul_diff")) +
    geom_hline(data=hlines, aes(yintercept=value, color=name)) +
    theme_bw() +
    ggtitle(args[1]) +
    scale_color_viridis(discrete=TRUE) +
    ggsave(args[2])
