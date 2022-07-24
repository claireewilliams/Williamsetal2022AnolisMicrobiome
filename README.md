# Williamsetal2022AnolisMicrobiome
GitHub repository for code and data associated with the manuscript "Sustained drought, but not short-term warming, alters the gut microbiome of wild Anolis lizards"


Folders 
Data: contains all data outputs associated with this manuscript. Raw data files are available under NCBI Bioproject PRJNA. 
	- liz-micro-metadata.tsv is the metadata file associated with the sequences 
	- Panama-Weather-Data-2017-through-2019 is the data for analyses about weather on the mainland and islands, as measured from the weather station
	on BCI and operative temperature models. 
	- PICRUST2/Kegg contains all the outputs associated with the functional inference analysis. 
	- QIIME2 contains all outputs from QIIME2. Within this folder are the overarching outputs for the entire dataset as well as subsets of the data for various 	
	comparisons contained in subfolders. 
	- ShortTermWarming contains all the data associated with the short term warming experiment - lizard temperatures throughout the experiment, lizard ids, 
	and physiology data. 

Figures: contains all figures for this publication
QIIME2 Commands: contains a script detailing all the analyses performed in QIIME2
R and Python Scripts: contain the scripts for all the analyses performed in R and Python. Data called in each of these scripts is found in the data folder. 
	- 2020_02_04_rdecontamscript.R is the script for performing decontam on the dataset. 
	- 2020_07_05_Regression_Physiology.Rmd is the script for the regressions on physiological data. 
	- 2021_05_25_Weather_Analysis_Script.Rmd is the script for performing analysis on the climate data. 
	- 2021_05_28_Python_and_RCombined_KeggProcessing.Rmd and KeggSortingScript.ipynb are the scripts for sorting and analyzing the outputs of
	PICRUST2
	- 2021_06_05_Figures.Rmd is the script for producing the majority of figures in the publication. 


	