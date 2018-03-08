
# https://medium.com/@dbaranger/showing-your-data-scatter-box-violin-plots-1f3bb06c8c2b

install.packages("DAAG")
install.packages("nlme")
install.packages("ggplot2")
install.packages("ggpubr")
install.packages("viridisLite")
install.packages("viridis")


library(DAAG)
library(nlme)
library(ggplot2)
library(ggpubr)
library(viridisLite)
library(viridis)

scidat<-na.omit(science)
scidat$like<-scidat$like+rnorm(n = length(scidat$like),mean = mean(scidat$like), sd = sd(scidat$like))


fit1<-lme(fixed = like ~ sex + PrivPub ,
          random = ~1|State/school/Class,
          data = scidat)
summary(fit1)


ggplot(data = scidat,aes(x = PrivPub, y = like, fill = sex))+geom_boxplot()


ggplot(data = scidat,aes(x = PrivPub, y = like, fill = sex))+
  geom_boxplot()+scale_fill_viridis(discrete=T)+
  theme_pubr()

  

ggplot(data = scidat,aes(x = PrivPub, y = like, fill = sex))+
  scale_fill_viridis(discrete=T)+
  geom_violin(alpha=0.25, position = position_dodge(width = .75),size=1,color="black") +
  geom_boxplot(notch = TRUE,  outlier.size = -1, color="black",lwd=1.2, alpha = 0.7)+
  theme_pubr()

ggplot(data = scidat,aes(x = PrivPub, y = like, fill = sex))+
  scale_fill_viridis(discrete=T)+
  geom_violin(alpha=0.4, position = position_dodge(width = .75),size=1,color="black") +
  geom_boxplot(notch = TRUE,  outlier.size = -1, color="black",lwd=1.2, alpha = 0.7)+
  geom_point( shape = 21,size=2, position = position_jitterdodge(), color="black",alpha=1)+
  theme_pubr()


ggplot(data = scidat,aes(x = PrivPub, y = like, fill = sex))+
  scale_fill_viridis(discrete=T)+
  geom_violin(alpha=0.4, position = position_dodge(width = .75),size=1,color="black") +
  geom_boxplot(notch = TRUE,  outlier.size = -1, color="black",lwd=1.2, alpha = 0.7)+
  geom_point( shape = 21,size=2, position = position_jitterdodge(), color="black",alpha=1)+
  theme_pubr()+
  ylab(  c("How much do they like science?")  )  +
  xlab(  c("Type of school")  )  +
  rremove("legend.title")+
  theme(panel.border = element_rect(colour = "black", fill=NA, size=2),
        axis.ticks = element_line(size=2,color="black"),
        axis.ticks.length=unit(0.2,"cm"),
        legend.position = c(0.92, 0.85))+
  font("xylab",size=15)+  
  font("xy",size=15)+ 
  font("xy.text", size = 15) +  
  font("legend.text",size = 15)



