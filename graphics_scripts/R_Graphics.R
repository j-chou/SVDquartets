library(ggplot2)
library(gridExtra)

mystats<-function(x) {
	c<-quantile(x,probs=c(0.25,0.75))
	#return(data.frame(upper=1,lower=3,middle=4,ymin=0,ymax=4))
	return(data.frame(upper=c[2],lower=c[1],middle=mean(x),ymin=min(x),ymax=max(x)))
}
mystderror<-function(x) {
	return(data.frame(ymax=mean(x)+sd(x)/sqrt(length(x)),ymin=mean(x)-sd(x)/sqrt(length(x))))
}
mymean<-function(x) {
	return(data.frame(y=mean(x)))
}
mylinetypescale<-function(x) {
	scale<-c("10","2111","41","11")
	return(scale[x])
}



data_full<-read.csv('combined.csv')
names(data_full)[c(2,4,5)]<-c('taxa','sites','genes')
data_full$sites_lab <- paste(data_full$sites,"sites")
data_full$genes_lab <- paste(data_full$genes,"genes")
data_full$sites_fact<-as.factor(data_full$sites)
names(data_full)[8]<-"Data"
names(data_full)[9]<-"Methods"
levels(data_full$Methods)[4]<-"SVDquartets+PAUP*"

#
# 11-Taxon Data
#
mydata<-data_full[((data_full$Data!=levels(data_full$Data)[6]) & (data_full$Data!=levels(data_full$Data)[5])),]
mydata$genes<-factor(mydata$genes,labels=c('100 Genes','500 Genes','1000 Genes'))
mydata$Data<-factor(mydata$Data,labels=c('11-Taxon: M1','11-Taxon: M2','11-Taxon: M3','11-Taxon: M4'))
c1<-data.frame(sites_fact=factor(10),FN.rate=.5,Data='11-Taxon: M1',genes=factor('100 Genes'),Methods=factor('RAxML'))
c2<-data.frame(sites_fact=factor(10),FN.rate=.5,Data='11-Taxon: M2',genes=factor('100 Genes'),Methods=factor('RAxML'))
c22<-data.frame(sites_fact=factor(10),FN.rate=0,Data='11-Taxon: M2',genes=factor('100 Genes'),Methods=factor('RAxML'))
c3<-data.frame(sites_fact=factor(10),FN.rate=0,Data='11-Taxon: M3',genes=factor('100 Genes'),Methods=factor('RAxML'))
c4<-data.frame(sites_fact=factor(10),FN.rate=0,Data='11-Taxon: M4',genes=factor('100 Genes'),Methods=factor('RAxML'))
dummy_data<-rbind(c1,c2,c3,c4,c22)

p<-ggplot(mydata,aes(x=sites_fact,y=FN.rate,group=Methods,color=Methods,linetype=Methods,size=Methods))+
	theme_gray()+theme(legend.position="bottom")+geom_blank(data=dummy_data)+
	stat_summary(fun.y=mean,geom="line")+
	scale_x_discrete(limits=c("10","25","50","100","200"))+
	scale_color_manual(breaks=levels(mydata$Methods),values = c("red","blue","seagreen","black"))+
	scale_linetype_manual(breaks=levels(mydata$Methods),values=c("solid",'21','31','41'))+
	scale_size_manual(breaks=levels(mydata$Methods),values=c(.75,.75,0.5,.75))+
	# stat_summary(fun.data=mystderror,position="dodge",geom="errorbar",width=0.5)+
	stat_summary(fun.data=mystderror,geom="errorbar",width=0.3)+
	facet_grid(Data~genes,scales="free_y")+
	labs(x="Number of Sites per Gene",y="FN Rate")
p
pdf(file="11-taxon_line_graph.pdf",height=9.9,width=7.5)
p
dev.off()
setEPS()
postscript("11-taxon_line_graph.eps",paper="special",height=9.9,width=7.5)
p
dev.off()

#ggsave("11-taxon_line_graph.pdf")
#ggsave("11-taxon_line_graph.eps")

#
# Mammalian Data
#

mydata_mam<-data_full[data_full$Data==levels(data_full$Data)[6],]
mydata_mam$genes<-factor(mydata_mam$genes,labels=c('50 Genes','100 Genes','200 Genes'))
c10<-data.frame(sites_fact=factor(10),FN.rate=0,Data='Mammal',genes=factor('100 Genes'),Methods=factor('NJst'))
p1<-ggplot(mydata_mam,aes(x=sites_fact,y=FN.rate,group=Methods,color=Methods,linetype=Methods,size=Methods))+
	theme_gray()+theme(legend.position="none")+geom_blank(data=c10)+
	stat_summary(fun.y=mean,geom="line")+
	scale_x_discrete(limits=c("10","25","50","100","200"))+
	scale_color_manual(breaks=levels(mydata$Methods),values = c("red","blue","black"))+
	scale_linetype_manual(breaks=levels(mydata$Methods),values=c("solid",'21','41'))+
	scale_size_manual(breaks=levels(mydata_mam$Methods),values=c(.75,.75,.75))+
	# stat_summary(fun.data=mystderror,position="dodge",geom="errorbar",width=0.5)+
	stat_summary(fun.data=mystderror,geom="errorbar",width=0.3)+
	facet_grid(Data~genes,scales="free_y")+
	labs(x="Number of Sites per Gene",y="FN Rate")
p1
pdf(file="Mammal_No_Legend.pdf",height=3.4,width=7.5)
p1; dev.off();
setEPS(); postscript("Mammal_No_Legend.eps",paper="special",height=3.4,width=7.5)
p1; dev.off();

#ggsave("Mammal - No Legend.pdf")
#ggsave("Mammal - No Legend.eps")
p12<-ggplot(mydata_mam,aes(x=sites_fact,y=FN.rate,group=Methods,color=Methods,linetype=Methods,size=Methods))+
	theme_gray()+theme(legend.position="bottom")+geom_blank(data=c10)+
	stat_summary(fun.y=mean,geom="line")+
	scale_x_discrete(limits=c("10","25","50","100","200"))+
	scale_color_manual(breaks=levels(mydata$Methods),values = c("red","blue","black"))+
	scale_linetype_manual(breaks=levels(mydata$Methods),values=c("solid",'21','41'))+
	scale_size_manual(breaks=levels(mydata_mam$Methods),values=c(.75,.75,.75))+
	# stat_summary(fun.data=mystderror,position="dodge",geom="errorbar",width=0.5)+
	stat_summary(fun.data=mystderror,geom="errorbar",width=0.3)+
	facet_grid(Data~genes,scales="free_y")+
	labs(x="Number of Sites per Gene",y="FN Rate")
p12
pdf(file="Mammal_With_Legend.pdf",height=3.4,width=7.5)
p12; dev.off();
setEPS(); postscript("Mammal_With Legend.eps",paper="special",height=3.4,width=7.5)
p12; dev.off();
#ggsave("Mammal - With Legend.pdf")
#ggsave("Mammal - With Legend.eps")

#
# 15-Taxon Data
#

mydata_15<-data_full[data_full$Data==levels(data_full$Data)[5],]
mydata_15$genes<-factor(mydata_15$genes,labels=c('100 Genes','500 Genes','1000 Genes'))
p2<-ggplot(mydata_15,aes(x=sites_fact,y=FN.rate,group=Methods,color=Methods,linetype=Methods,size=Methods))+
	theme_gray()+theme(legend.position="none")+
	stat_summary(fun.y=mean,geom="line")+
	scale_color_manual(breaks=levels(mydata_15$Methods),values = c("red","blue","seagreen","black"))+
	scale_linetype_manual(breaks=levels(mydata_15$Methods),values=c("solid",'21','31','41'))+
	scale_size_manual(breaks=levels(mydata_15$Methods),values=c(.75,.75,0.5,.75))+
	# stat_summary(fun.data=mystderror,position="dodge",geom="errorbar",width=0.5)+
	stat_summary(fun.data=mystderror,geom="errorbar",width=0.3)+
	facet_grid(Data~genes,scales="free_y")+
	labs(x="Number of Sites per Gene",y="FN Rate")
p2
pdf(file="15-Taxon - No Legend.pdf",height=3.4,width=7.5)
p2; dev.off();
setEPS(); postscript("15-Taxon - No Legend.eps",paper="special",height=3.4,width=7.5)
p2; dev.off();
#ggsave("15-Taxon - No Legend.pdf")
#ggsave("15-Taxon - No Legend.eps")

p22<-ggplot(mydata_15,aes(x=sites_fact,y=FN.rate,group=Methods,color=Methods,linetype=Methods,size=Methods))+
	theme_gray()+theme(legend.position="bottom")+
	stat_summary(fun.y=mean,geom="line")+
	scale_color_manual(breaks=levels(mydata_15$Methods),values = c("red","blue","seagreen","black"))+
	scale_linetype_manual(breaks=levels(mydata_15$Methods),values=c("solid",'21','31','41'))+
	scale_size_manual(breaks=levels(mydata_15$Methods),values=c(.75,.75,0.5,.75))+
	# stat_summary(fun.data=mystderror,position="dodge",geom="errorbar",width=0.5)+
	stat_summary(fun.data=mystderror,geom="errorbar",width=0.3)+
	facet_grid(Data~genes,scales="free_y")+
	labs(x="Number of Sites per Gene",y="FN Rate")
p22
pdf(file="15-Taxon - With Legend.pdf",height=3.4,width=7.5)
p22; dev.off();
setEPS(); postscript("15-Taxon - With Legend.eps",paper="special",height=3.4,width=7.5)
p22; dev.off()
#ggsave("15-Taxon - With Legend.pdf")
#ggsave("15-Taxon - With Legend.eps")
