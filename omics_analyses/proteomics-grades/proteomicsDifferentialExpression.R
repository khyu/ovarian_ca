# proteomicsDifferentialExpression.R
#
# Proteomics data from CPTAC
# grade 1, 2 versure grade 3 differential expression analyses
#
# Kun-Hsing Yu


rm(list=ls())

## fold change
# read files
proteomicsFile<-read.table("proteomics.csv", sep=",")
proteomicsIDs<-read.table("proteomicsID.csv", sep=",", stringsAsFactors=F)
proteomicsGeneNames<-read.table("proteinNames.csv", sep=",", stringsAsFactors=F)

proteomics<-t(proteomicsFile[,order(proteomicsIDs[1,])])
proteomicsIDs<-proteomicsIDs[1,order(proteomicsIDs[1,])]

clinicalOV<-read.table("nationwidechildrens.org_clinical_patient_ov.txt", sep="\t", skip=3, stringsAsFactors=F)

grade<-as.data.frame(cbind(clinicalOV[,2],clinicalOV[,20]))
grade[,2]<-as.character(grade[,2])
grade<-grade[(grade[,2]=="G1" | grade[,2]=="G2" | grade[,2]=="G3"),]
grade[(grade[,2]=="G1" | grade[,2]=="G2"),2]<-0
grade[(grade[,2]=="G3"),2]<-1
grade[,2]<-as.numeric(grade[,2])
grade[,1]<-as.character(grade[,1])
colnames(grade)[2]<-"grade"

idIntersect<-intersect(grade[,1],substr(proteomicsIDs,1,12))
proteomicsSelectedRow<-((substr(proteomicsIDs,1,12) %in% idIntersect) & (substr(proteomicsIDs,13,16)!="-01R"))

proteomicsSelected<-proteomics[proteomicsSelectedRow,]
proteomicsIDs<-proteomicsIDs[proteomicsSelectedRow]

gradeSelected<-grade[(grade[,1] %in% idIntersect),]

foldChange<-rep(0,dim(proteomicsSelected)[2])
pValue<-rep(-1,dim(proteomicsSelected)[2])

for (i in 1:dim(proteomicsSelected)[2]){
  foldChange[i]<-mean(proteomicsSelected[gradeSelected[,2]==1,i],na.rm=T)-mean(proteomicsSelected[gradeSelected[,2]==0,i],na.rm=T)
  pValue[i]<-wilcox.test(proteomicsSelected[gradeSelected[,2]==1,i],proteomicsSelected[gradeSelected[,2]==0,i])$p.value
}

pCorrected<-p.adjust(pValue[!is.na(pValue) & (foldChange>=quantile(foldChange,0.99) | foldChange<=quantile(foldChange,0.01))],method="BH")
pCorrectedIndex<-which(!is.na(pValue) & (foldChange>=quantile(foldChange,0.99) | foldChange<=quantile(foldChange,0.01)))

foldChangedProteomics<-proteomicsGeneNames[pCorrectedIndex,]
foldChangedProteomics<-foldChangedProteomics[pCorrected<0.05,]

foldChangeAmount<-foldChange[pCorrectedIndex]
foldChangeAmount<-foldChangeAmount[pCorrected<0.05]

write.table(foldChangedProteomics,"foldChangedProteomics.txt",quote=F, row.names=F, col.names=F)
