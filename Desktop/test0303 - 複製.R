install.packages("DAAG")
install.packages("nlme")
install.packages("ggplot2")
install.packages("ggpubr")
install.packages("viridisLite")

library(DAAG)
library(nlme)
library(ggplot2)
library(ggpubr)
library(viridisLite)

scidat<-na.omit(science)
scidat$like<-scidat$like+rnorm(n = length(scidat$like),mean = mean(scidat$like), sd = sd(scidat$like))


fit1<-lme(fixed = like ~ sex + PrivPub ,
          random = ~1|State/school/Class,
          data = scidat)
summary(fit1)


ggplot(data = scidat,aes(x = PrivPub, y = like, fill = sex))+
  geom_boxplot()


  



