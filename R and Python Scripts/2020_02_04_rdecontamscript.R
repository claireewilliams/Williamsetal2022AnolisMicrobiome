# this script is to identify and decontaminate Lizard Micro sequencing data
# it is based on: https://benjjneb.github.io/decontam/vignettes/decontam_intro.html
# Adapted by Claire Williams, February 2020 

#install decontam via BiocManager
# BiocManager::install("decontam")

## Required Libraries
library(phyloseq)
library(qiime2R)
library(ggplot2)
library(decontam)
library(readr)


## import metadata file
metadata<-read_tsv("liz-micro-metadata.tsv")

## import qiime2 Files as Phyloseq object 
phy<-qza_to_phyloseq("pet-table.qza", "rooted-tree.qza","silva-taxonomy.qza", "liz-micro-metadata.tsv")

## overview of sample data
sd<-sample_data(phy)

## construct data frame from phy object
df<-as.data.frame(sample_data(phy))

## determine library size and create column to include it 
df$LibrarySize<-sample_sums(phy)

## order data frame based on LibrarySize
df<-df[order(df$LibrarySize),]

##  create a column called index to order by library size. 
df$Index<-seq(nrow(df))

## plot library sizes and show control and samples in different colors 
ggplot(data=df, aes(x=Index, y=LibrarySize, color=sample.or.control)) +
  geom_point()

#create a factor to identify the negatives
sd$is.neg<-sd$`sample-or-control` == "control"

##  identify contaminants via prevalence method ## 
contamdf.prev<-isContaminant(phy, method='prevalence', neg=sd$is.neg, threshold = 0.5)

# create a table of the contaminants (17)
table(contamdf.prev$contaminant)
head(which(contamdf.prev$contaminant))


# examine how often contaminants present in controls vs the samples
# transfmorme sample counts in the phyloseq object
phy.pa<-transform_sample_counts(phy, function(abund) 1*(abund>0))

# extract data
samples.phy.pa<-sample_data(phy.pa)

#create two data frames with the controls and the samples
phy.pa.neg<-prune_samples(samples.phy.pa$`sample-or-control` =="control", phy.pa)
phy.pa.pos<-prune_samples(samples.phy.pa$`sample-or-control` =="sample", phy.pa)

# combine them to show how often contaminants are present in controls or samples 
df.pa<-data.frame(pa.pos=taxa_sums(phy.pa.pos), pa.neg=taxa_sums(phy.pa.neg),
                  contaminant= contamdf.prev$contaminant) 
# plot 
ggplot(data=df.pa, aes(x=pa.neg, y=pa.pos, color=contaminant)) + geom_point() +
  xlab("Prevalence(Negative Controls)") + ylab("Prevalence (True Samples)")


## identify ASVs are contaminants - create a list of them. 
colnamed<- which(contamdf.prev$contaminant)
contam.asvs<-rownames(contamdf.prev)[colnamed]

## use write.xlsx to transfer to xl file
# contaminantASVs.xlsx 