# proteomicsPtResponse.R
#
# proteomics platinum response
#
# Kun-Hsing Yu

rm(list=ls())
setwd("~/Dropbox (HMS)/tcgaOV/omicsPtResponse")

proteomicsFile<-read.table("proteomics.csv", sep=",")
proteomicsIDs<-read.table("proteomicsID.csv", sep=",", stringsAsFactors=F)
proteomicsGeneNames<-read.table("proteinNames.csv", sep=",", stringsAsFactors=F)

proteomics<-t(proteomicsFile[,order(proteomicsIDs[1,])])
proteomicsIDs<-proteomicsIDs[1,order(proteomicsIDs[1,])]

pfi<-read.table("../cnn/pfi/regression/filenames/pfiCensoringUnion.txt", sep=" ", stringsAsFactors=F)

pfi<-pfi[pfi[,3]==1,]

idIntersect<-intersect(pfi[,1],substr(proteomicsIDs,1,12))
proteomicsSelectedRow<-((substr(proteomicsIDs,1,12) %in% idIntersect) & (substr(proteomicsIDs,13,16)!="-01R"))

proteomicsSelected<-proteomics[proteomicsSelectedRow,]
proteomicsIDs<-proteomicsIDs[proteomicsSelectedRow]

pfiSelected<-pfi[(pfi[,1] %in% idIntersect),]

corr<-rep(-2,dim(proteomicsSelected)[2])
pValue<-rep(-1,dim(proteomicsSelected)[2])

for (i in 1:dim(proteomicsSelected)[2]){
  corr[i]<-cor(proteomicsSelected[,i],pfiSelected[,2],method="spearman")
  pValue[i]<-cor.test(proteomicsSelected[,i],pfiSelected[,2],method="spearman")$p.value
}

pCorrected<-p.adjust(pValue[pValue>-1 & (corr>=quantile(corr,0.99) | corr<=quantile(corr,0.01))],method="BH")
pCorrectedIndex<-which(pValue>-1 & (corr>=quantile(corr,0.99) | corr<=quantile(corr,0.01)))

corrSigProteomics<-proteomicsGeneNames[pCorrectedIndex,]
corrSigProteomics<-corrSigProteomics[pCorrected<0.05,]

corrAmount<-corr[pCorrectedIndex]
corrAmount<-corrAmount[pCorrected<0.05]
sum(corrAmount>0)
sum(corrAmount<0)

write.table(corrSigProteomics,"corrSigProteomics.txt",quote=F, row.names=F, col.names=F)
