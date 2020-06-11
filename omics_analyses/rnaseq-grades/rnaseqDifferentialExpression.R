# rnaseqDifferentialExpression.R
#
# tcgaOV RNASeq grade
# using the FPKM data from TCGA
#
# grade 1, 2 versure grade 3 differential expression analyses
#
# Kun-Hsing Yu


rm(list=ls())

library(ggplot2)

# read files
load("../data/fpkm.RData")
rnaSeqIDs<-read.table("../data/fpkmID.txt", sep=",", stringsAsFactors=F)
rnaSeqElemIDs<-read.table("../data/fpkmGeneNames.txt", sep=",", stringsAsFactors=F)

rnaSeq<-rnaSeqFile[order(rnaSeqIDs[,1]),]
rnaSeqIDs<-rnaSeqIDs[order(rnaSeqIDs[,1]),1]

clinicalOV<-read.table("../data/clinical.txt", sep="\t", skip=3, stringsAsFactors=F)
table(clinicalOV[,20])

grade<-as.data.frame(cbind(clinicalOV[,2],clinicalOV[,20]))
grade[,2]<-as.character(grade[,2])
grade<-grade[(grade[,2]=="G1" | grade[,2]=="G2" | grade[,2]=="G3"),]
grade[(grade[,2]=="G1" | grade[,2]=="G2"),2]<-0
grade[(grade[,2]=="G3"),2]<-1
grade[,2]<-as.numeric(grade[,2])
grade[,1]<-as.character(grade[,1])
colnames(grade)[2]<-"grade"

idIntersect<-intersect(grade[,1],substr(rnaSeqIDs,1,12))
rnaSeqSelectedRow<-((substr(rnaSeqIDs,1,12) %in% idIntersect))

rnaSeqSelected<-rnaSeq[rnaSeqSelectedRow,]
rnaSeqIDs<-rnaSeqIDs[rnaSeqSelectedRow]

rnaSeqSelected<-rnaSeqSelected[!duplicated(substr(rnaSeqIDs,1,12)),]
rnaSeqIDs<-rnaSeqIDs[!duplicated(substr(rnaSeqIDs,1,12))]

gradeSelected<-grade[(grade[,1] %in% idIntersect),]

foldChange<-rep(NA,dim(rnaSeqSelected)[2])
pValue<-rep(NA,dim(rnaSeqSelected)[2])

for (i in 1:dim(rnaSeqSelected)[2]){
  if (mean(rnaSeqSelected[gradeSelected[,2]==1,i],na.rm=T)!=0 & mean(rnaSeqSelected[gradeSelected[,2]==0,i],na.rm=T)!=0){
    foldChange[i]<-mean(rnaSeqSelected[gradeSelected[,2]==1,i],na.rm=T)/mean(rnaSeqSelected[gradeSelected[,2]==0,i],na.rm=T)
    pValue[i]<-wilcox.test(rnaSeqSelected[gradeSelected[,2]==1,i],rnaSeqSelected[gradeSelected[,2]==0,i])$p.value
  }
}

pCorrected<-p.adjust(pValue[!is.na(pValue) & (foldChange>=quantile(foldChange,0.99,na.rm=T) | foldChange<=quantile(foldChange,0.01,na.rm=T))],method="BH")
pCorrectedIndex<-which(!is.na(pValue) & (foldChange>=quantile(foldChange,0.99,na.rm=T) | foldChange<=quantile(foldChange,0.01,na.rm=T)))

foldChangedRNAseq<-rnaSeqElemIDs[pCorrectedIndex,]
foldChangedRNAseq<-foldChangedRNAseq[pCorrected<0.05,]

write.table(t(foldChangedRNAseq), "rnaseqOutliersBH.txt", quote=F, row.names=F, col.names=F)
