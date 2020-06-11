# rnaseqPtResponse.R
#
# RNASeq platinum response
#
# Kun-Hsing Yu

rm(list=ls())

# read files
load("../data/fpkm.RData")
rnaSeqIDs<-read.table("../data/fpkmID.txt", sep=",", stringsAsFactors=F)
rnaSeqElemIDs<-read.table("../data/fpkmGeneNames.txt", sep=",", stringsAsFactors=F)

rnaSeq<-rnaSeqFile[order(rnaSeqIDs[,1]),]
rnaSeqIDs<-rnaSeqIDs[order(rnaSeqIDs[,1]),1]

pfi<-read.table("../data/pfi.txt", sep=" ", stringsAsFactors=F)

pfi<-pfi[pfi[,3]==1,]

idIntersect<-intersect(pfi[,1],substr(rnaSeqIDs,1,12))
rnaSeqSelectedRow<-((substr(rnaSeqIDs,1,12) %in% idIntersect) & (substr(rnaSeqIDs,13,16)!="-01R"))

rnaSeqSelected<-rnaSeq[rnaSeqSelectedRow,]
rnaSeqIDs<-rnaSeqIDs[rnaSeqSelectedRow]

rnaSeqSelected<-rnaSeqSelected[!duplicated(substr(rnaSeqIDs,1,12)),]
rnaSeqIDs<-rnaSeqIDs[!duplicated(substr(rnaSeqIDs,1,12))]

pfiSelected<-pfi[(pfi[,1] %in% idIntersect),]

corr<-rep(-2,dim(rnaSeqSelected)[2])
pValue<-rep(-1,dim(rnaSeqSelected)[2])

for (i in 1:dim(rnaSeqSelected)[2]){
  corr[i]<-cor(rnaSeqSelected[,i],pfiSelected[,2],method="spearman")
  pValue[i]<-cor.test(rnaSeqSelected[,i],pfiSelected[,2],method="spearman")$p.value
}

pCorrected<-p.adjust(pValue[!is.na(pValue) & (corr>=quantile(corr,0.99, na.rm=T) | corr<=quantile(corr,0.01, na.rm=T))],method="BH")
pCorrectedIndex<-which(!is.na(pValue) & (corr>=quantile(corr,0.99, na.rm=T) | corr<=quantile(corr,0.01, na.rm=T)))

corrSigRNAseq<-rnaSeqElemIDs[pCorrectedIndex,]
corrSigRNAseq<-corrSigRNAseq[pCorrected<0.05,]

write.table(corrSigRNAseq,"corrSigRNAseq.txt",quote=F, row.names=F, col.names=F)


