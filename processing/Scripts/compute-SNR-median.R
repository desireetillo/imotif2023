## ---------------------------
##
## Script name: compute-SNR-median.R
##
## Computes median/mean SNR635 for each test sequence on iMotif array
## Generates histograms of SNR635 distribution across sequence classes
##
## Author: Desiree Tillo
##
## Date edited: 2023-03-09
##
## Email: desiree.tillo@nih.gov
##

library(dplyr)
library(ggplot2)

# read in data
args = commandArgs(trailingOnly=TRUE)
# DEBUG
#file<-"block.1.Mitoxantrone_Array.txt"
#prefix<-'test'

file<-args[1]
prefix<-args[2]

dat <- read.delim(here::here('data_v2',file),sep="\t")
info<-read.delim(here::here("info/iMotif_array_v2_uniq_probes.long.txt"),sep="\t")
jdata<-left_join(info,dat,by=c("Old_ID"="ID"))
jdata$SeqClass <- gsub("V2_","",jdata$SeqClass)

# Summarize the data
sum_data<-jdata%>%
  group_by(New_ID,SeqClass)%>%
  summarise(across(
    .cols = c('SNR.635','SNR.532','SNR.488'),
    .fns = list(Median=median,Mean = mean, SD = sd), na.rm = TRUE,
    .names = "{col}_{fn}"
  ))

# density histogram
ggplot(sum_data,aes(x=SNR.635_Median,color=SeqClass)) +
  geom_density() +
  theme_bw() +
  ggtitle(prefix) +
  xlab('Median SNR635')

out_fig<-paste0('figs/',prefix, ".feature_histogram.png")
ggsave(out_fig, width=6,height=4)

# density histogram, facets
ggplot(sum_data,aes(x=SNR.635_Median,color=SeqClass)) +
  facet_wrap(vars(SeqClass),scales = "free_y")+
  geom_density() +
  theme_bw() +
  ggtitle(prefix) +
  xlab('Median SNR635')

out_fig<-paste0('figs/',prefix, ".feature_histogram.facet.png")
ggsave(out_fig, width=6,height=8)

names(sum_data)[3:ncol(sum_data)]<-paste0(prefix,'.',names(sum_data)[3:ncol(sum_data)])
out_file<-paste0('processed/',prefix, ".summarized.csv")
write.table(sum_data,out_file,sep=',',quote=F,row.names=F)
