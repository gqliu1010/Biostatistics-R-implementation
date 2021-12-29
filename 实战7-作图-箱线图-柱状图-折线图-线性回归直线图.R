# --------------Biostatistics with R--------------------
# author: Guoqing Liu
# email: gqliu1010@163.com
# affiliation: Inner Mongolia University of Science and Technology
# Acknowlegments: 
# 1．生物统计学，李春喜，科学出版社，2018年（第五版）
# 2. 实用生物统计学,李松岗 曲红， 高等教育出版社，2012年，第二版
# 3. 统计学习导论基于R 应用，力雷斯•詹姆斯等著，王星等译
#  ------------------------------------------------------



#1. 用R语言读入文本文件（file1_GC.txt)，第一列数据标记为“control”，第二列数据标记为“treatment”。 
#（1）计算每一列数据的平均值和标准偏差；
#（2）计算两列数据的平均数之间是否有显著差异（用t检验）；
#（3）画两列数据的箱线图(boxplot)；
#（4）画两列数据的柱状图(barplot)。


#（1）
data=read.table("file1_GC.txt",header=T,stringsAsFactors = F)
x1=data[,1]
x2=data[,2]
aver1=mean(x1)
aver2=mean(x2)
sd1=sd(x1)
sd2=sd(x2)

#（2）
t.test(x1,x2)
#得到结果t = -56.458, df = 5074, p-value < 2.2e-16

#（3）
z=c(x1,x2)
cls=factor(c(rep("treatment",length(x1)),rep("control",length(x2))),levels=c("treatment","control"))
levels(cls)

jpeg("Figure1_boxplot.jpeg",width=600*2,height=500*2,res=142*2)
boxplot(z~cls,main="GC content",xlab="",ylab="",las=1,col="pink",outline=F,notch=T)  
#las=1纵轴刻度值转90度, 试试las=0,las=2,las=3
#outline=F, outliers are not drawn
#notch=T,中位数位置画凹口,a notch is drawn in each side of the boxes. If the notches of two plots do not overlap this is ‘strong evidence’ that the two medians differ

#图上加文字内容
text(x=1.5,y=0.7,"p-value < 2.2e-16",cex = 0.8,xpd=T)  #xpd=T决定坐标轴边框外也输出
dev.off()

#（4）
########画柱状图################
x=c("treatment","control")
y=c(aver1,aver2)
jpeg("Figure2_barplot.jpeg",width=600*2,height=500*2,res=142*2)
fg1=barplot(y,ylab="GC content",las=1,col="pink",names.arg=x)  
#fg1里存放的是柱状的横坐标位置
#las=1纵轴刻度值转90度, 试试las=0,las=2,las=3
#las=0表示label与axis平行方向las=2垂直方向 las=1表示横纵坐标label都水平方向； xaxt="n"不显示横坐标

###arrows(x0, y0, x1 = x0, y1 = y0, length = 0.25, angle = 30, code = 2, col = par("fg"), lty = par("lty"),lwd = par("lwd"), ...)
#x0, y0	coordinates of points from which to draw.
#x1, y1	coordinates of points to which to draw. At least one must the supplied
#angle,angle from the shaft (箭轴) of the arrow to the edge (箭头边) of the arrow head.
#length,length of the edges of the arrow head (in inches).
arrows(x0=fg1[1], y0=aver1, x1=fg1[1], y1=aver1+sd1, angle = 90,xpd=T)
arrows(x0=fg1[2], y0=aver2, x1=fg1[2], y1=aver2+sd2, angle = 90,xpd=T)

lines( x = c(fg1[1], fg1[1], fg1[2], fg1[2]), y = c( (aver1+sd1) * 1.05 , (aver2+sd2)* 1.1,  (aver2+sd2) * 1.1, (aver2+sd2) * 1.05), lty = 1,xpd=T,col="red")
#text( x = fg1[1] + (fg1[2] - fg1[1]) / 2, y = (aver2+sd2) * 1.1, label = "****", cex = 1, adj = c(0.5, 0),xpd=T)
text( x = fg1[1] + (fg1[2] - fg1[1]) / 2, y = (aver2+sd2) * 1.1, label = "p<2.2e-16", cex = 1, adj = c(0.5, 0),xpd=T)
##adj = c(0.5, 0) #取值[0,1]之间的数据，第一个数字控制添加的文本的水平对齐方式，第二个数字控制纵向对齐方式。0.5表示居中。
##x = fg1[1] + (fg1[2] - fg1[1]) / 2,表示添加文字的位置是在两个柱状正中间
##label = paste0("p=",format(p.value,scientific=TRUE,digit=2)) #这是对较小的pvalue用行科学计数法表示，小数点后留两位有效数字。
###xpd=T决定坐标轴边框外也输出
##cex控制字体大小
dev.off()



##例7.1：有人研究黏虫孵化历期平均温度与历期天数之间的关系，试验资料如下。
#平均温度：11.8,14.7,15.6,16.8,17.1,18.8,19.5,20.4
#历期天数：30.1,17.3,16.7,13.6,11.9,10.7,8.3,6.7
#(1)试建立直线回归方程；
#(2)画散点图并添加回归直线；
#(3)画折线图。


#(1)
x=c(11.8,14.7,15.6,16.8,17.1,18.8,19.5,20.4)
y=c(30.1,17.3,16.7,13.6,11.9,10.7,8.3,6.7)
model=lm(y~x)
#model里存放着计算结果，包括截距，回归系数等
intercept=model$coefficients[1]
slope=model$coefficients[2]
summary(model)

#得到intercept=57, slope=-2.53
#summary(model)后能看到回归系数slope的t检验结果：统计量t=-9.48, pvalue=7.85e-05
#推断：pvalue=7.85e-05，pvalue<0.05, 因此历期平均温度与历期天数之间存在显著的线性回归关系。

#summary(model)也能看到回归系数slope的F检验结果：F-statistic: 89.87 on 1 and 6 DF,  p-value: 7.848e-05
#推断：pvalue=7.848e-05，pvalue<0.05, 因此历期平均温度与历期天数之间存在显著的线性回归关系。

#(2)
jpeg("Figure3_regression_plot.jpeg",width=600*2,height=500*2,res=142*2)
#par(mfcol=c(1,1)) #将画图窗口分成1行1列
par(cex=1)  #调整所有字体大小，包括刻度值和标签
par(mar=c(4,4,4,2)) #设置主图与图边缘的距离
par(mgp = c(2, 0.5, 0))#mgp中第一个数字控制label的位置，第二个控制刻度值的位置，第三个控制轴的位置

plot(x,y,main="Linear regression plot",xlab="历期平均温度",ylab="历期天数")
abline(model,col="red",lwd=2,lty=2)  #添加回归直线
#或者lines(x,fitted(model))  #或者lines(x,fitted.values(model))#或者lines(x,model$fitted.values)
#lines(lowess(x,y),col="blue",lwd=2,lty=1) ##添加平滑拟合曲线

#图上加文字内容
text(x=19,y=28,"p=7.85e-05",xpd=T)  #xpd=T决定坐标轴边框外也输出
dev.off()

#(3)
########画折线图################
jpeg("Figure4_lineChart.jpeg",width=600*2,height=500*2,res=142*2)
#par(mfcol=c(1,1)) #将画图窗口分成1行1列
par(cex=1)  #调整所有字体大小，包括刻度值和标签
par(mar=c(4,4,4,2)) #设置主图与图边缘的距离
par(mgp = c(2, 0.5, 0))#mgp中第一个数字控制label的位置，第二个控制刻度值的位置，第三个控制轴的位置

plot(x,y,main="折线图",xlab="历期平均温度",ylab="历期天数",pch=20,lty=1,type="o")
##type决定折线图样式，包括p(只有点),l(只有线),o(实心点和线),b(线连接点，点线有间隙)
##pch决定点的样式：
#当pch取0~14时，其点为空心点，可以用col(颜色)参数设置其边框的颜色；
#当pch取15~20时，其点是实心点，可以用col参数设置其填充的颜色；
#当pch取21~25时，其点也是实心点，既可以用col参数设置边框的颜色，也可以用bg参数设置其内部的填充颜色。
dev.off()





##例7.8：有人研究黏虫孵化历期平均温度与历期天数之间的关系，试验资料如下。
#（1）试分析历期温度与历期天数之间的相关性。
#（2）画散点图，并添加回归直线和相关系数和p-value
#平均温度：11.8,14.7,15.6,16.8,17.1,18.8,19.5,20.4
#历期天数：30.1,17.3,16.7,13.6,11.9,10.7,8.3,6.7


#（1）
x=c(11.8,14.7,15.6,16.8,17.1,18.8,19.5,20.4)
y=c(30.1,17.3,16.7,13.6,11.9,10.7,8.3,6.7)
cor.test(x,y)
#得到结果：t = -9.4798, df = 6, p-value = 7.848e-05, corr.coefficient=-0.9682
#推断：p-value<0.05, 相关系数r=-0.9682, 因此历期平均温度与历期天数之间存在显著的负相关性。

#（2）
jpeg("Figure5_correlation_plot.jpeg",width=600*2,height=500*2,res=142*2)
#par(mfcol=c(1,1)) #将画图窗口分成1行1列
par(cex=1)  #调整所有字体大小，包括刻度值和标签
par(mar=c(4,4,4,2)) #设置主图与图边缘的距离
par(mgp = c(2, 0.5, 0))#mgp中第一个数字控制label的位置，第二个控制刻度值的位置，第三个控制轴的位置

plot(x,y,main="相关性分析图",xlab="历期平均温度",ylab="历期天数")
abline(lm(y~x),col="blue",lwd=2,lty=1)  #添加回归直线
#图上加文字内容
text(x=16,y=28,"R=-0.9682, p=7.848e-05",xpd=T)  #xpd=T决定坐标轴边框外也输出
dev.off()
