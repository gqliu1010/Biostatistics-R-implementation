# --------------Biostatistics with R--------------------
# author: Guoqing Liu
# email: gqliu1010@163.com
# affiliation: Inner Mongolia University of Science and Technology
# Acknowlegments: 
# 1．生物统计学，李春喜，科学出版社，2018年（第五版）
# 2. 实用生物统计学,李松岗 曲红， 高等教育出版社，2012年，第二版
# 3. 统计学习导论基于R 应用，力雷斯•詹姆斯等著，王星等译
#  ------------------------------------------------------
                   

# 例1：产生1-10的整数，计算其平均值，中位数、众数、极差、方差、标准偏差、和变异系数。

x=seq(1,10,by=1)
mean(x)
median(x)
range(x)
range=max(x)-min(x)
var(x)
sd(x)
sd(x)/mean(x)#变异系数
which.max(table(x)) #众数

aver=mean(x, na.rm = TRUE)##计算中不包括NA
print(aver)




# 例2：求以下数列1，2，5，7，9平均值，中位数、极差、方差、标准偏差、和变异系数。
x=c(1,2,5,7,9)   #x is a vector
mean(x)
median(x)
range(x)
range=max(x)-min(x)
var(x)
sd(x)
sd(x)/mean(x)




# 例3：读入文本文件（file1_GC.txt)，并计算每列平均值。
# apply(b,1,mean) #每行求和,试试mean替换为sum,max
# apply(b,2,mean) #每列求和

data1<- read.table(file = "file1_GC.txt",  header =F, sep="\t",stringsAsFactors=F)
#data1<-as.data.frame(lapply(data1,as.numeric))
aver1<-apply(data1,2,mean,na.rm=T)




# 例4：读入文本文件（file2_GC.txt)，并计算每列平均值，并将结果存入文本文件（如aver_GC.txt)
rm(list=ls())
data1<- read.table(file = "file2_GC.txt", row.names=1, header =T, sep="\t",stringsAsFactors=F)
#data1<-as.data.frame(lapply(data1,as.numeric))
aver1<-apply(data1,2,mean,na.rm=T)
write.table(aver1,"aver_GC.txt",row.names = F,col.names = F,sep='\t',quote=F)

