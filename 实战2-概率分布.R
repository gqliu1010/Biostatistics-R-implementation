# --------------Biostatistics with R--------------------
# author: Guoqing Liu
# email: gqliu1010@163.com
# affiliation: Inner Mongolia University of Science and Technology
# Acknowlegments: 
# 1．生物统计学，李春喜，科学出版社，2018年（第五版）
# 2. 实用生物统计学,李松岗 曲红， 高等教育出版社，2012年，第二版
# 3. 统计学习导论基于R 应用，力雷斯•詹姆斯等著，王星等译
#  ------------------------------------------------------

# 背景：
# (1)R语言中可以快速计算服从某种理论分布的变量的观测值对应的概率函数值(或概率密度值)。
# (2)R语言中可以快速计算服从某种理论分布的变量的观测值对应的累积分布函数值（累积概率值）。
# (3)R语言中可以快速计算累积概率值p与每次试验成功的概率prob对应的随机变量观测值（即概率分布曲线上x轴坐标）。
# (4)R语言中可以快速产生符合某种理论分布的一系列数据。



 
# 备注：
# R语言有四个内置函数来解决二项分布相关的计算问题。其他分布也类似。
# dbinom(x, size, prob) # probability function (probability density)
# pbinom(x, size, prob)  #cumulative probability function
# qbinom(p, size, prob)  #该函数计算出累积概率值p与每次试验成功的概率prob对应的随机变量观测值（即概率分布曲线上x轴坐标）。
# rbinom(n, size, prob)  #在1-size范围内产生服从二项分布的n个数据(相当于做n组实验，每组实验有size个试验，如100次抛硬币；该函数产生的每一个数据是硬币在size个试验中正面朝上出现的次数)。prob是每次试验成功的概率，如抛硬币时正面朝上出现的概率prob=1/2; 抛骰子的话某一特定点数出现的概率为prob=1/6，不出现该点数的概率为5/6
# 
# 以下是所使用的参数的描述：
# x是随机变量观测值向量(一个数据或一组数据，例如100次抛硬币试验中出现正面朝上的次数）。
# p是累积概率向量(一个数据或一组数据）。
# size是试验的数量。
# prob是每次试验成功的概率。
# n表示n组实验（不是试验次数，见上）



# 泊松分布相关函数：
# dpois(x,lambda)   ##计算观测值x出现的概率
# ppois(x,lambda)  ##计算0-x范围的累积概率
# qpois(p,lambda)  ##计算累积概率p对应的观测值x
# rpois(n,lambda)  ##产生服从泊松分布的n个随机数


 
# 正态分布相关函数：
# dnorm(x, mean = 0, sd = 1, log = FALSE)
# 返回值是正态分布概率密度函数值，比如dnorm（z）则表示：标准正态分布概率密度函数f（x）在x=z处的函数值。
# pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
# 返回值是正态分布的分布函数值，比如pnorm（z）等价于P[X ≤ z]
# qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
# 返回值是给定概率p后的下分位点（即累积概率p对应的观测值）
# rnorm(n, mean = 0, sd = 1)
# 返回值是n个正态分布随机数构成的向量。
# 
# 备注： log = FALSE，  lower.tail = TRUE,   log.p = FALSE是函数默认参数，可有可无。
# log = FALSE和 log.p = FALSE表示计算的概率值不进行对数变换
# lower.tail = TRUE表示计算左侧（左尾）对应的值（累积概率，或累积概率对应的观测值）



# t分布相关函数：
# dt(x, df, ncp, log = FALSE)
# pt(q, df, ncp, lower.tail = TRUE, log.p = FALSE)
# qt(p, df, ncp, lower.tail = TRUE, log.p = FALSE)
# rt(n, df, ncp)
# 
# 备注：若没有特殊要求的话，省略默认参数ncp = 0, log = FALSE，  lower.tail = TRUE, log.p = FALSE 等即可。




# 卡方分布相关函数：
# dchisq(x, df, ncp = 0, log = FALSE)
# pchisq(q, df, ncp = 0, lower.tail = TRUE, log.p = FALSE)
# qchisq(p, df, ncp = 0, lower.tail = TRUE, log.p = FALSE)
# rchisq(n, df, ncp = 0)
# 
# 备注：若没有特殊要求的话，省略默认参数ncp = 0, log = FALSE，  lower.tail = TRUE, log.p = FALSE 等即可。





# 例1：
# (1)计算10次重复抛掷硬币试验中，精确找到3次正面朝上的概率。
# 解：
dbinom(3, 6, 0.5)

# (2)在50次抛硬币试验中，获得0—25次正面朝上的累积概率为多少？
# 解：
cf <- pbinom(25,50,0.5)
print(cf)


# (3)假设每次抛骰子点数1出现的概率为1/6，每组实验由100次抛骰子试验组成，试在0—100范围内产生10000个服从二项分布的整数，并作频数分布图。
# 解：
n <- 10000
size <- 100   #1-size范围内产生二项分布的n个数据
prob <- 1/6
x <- rbinom(n, size, prob)
hist(x )


# 例3.4：
dbinom(0,4,3/4)
dbinom(1,4,3/4)
dbinom(2,4,3/4)
dbinom(3,4,3/4)
dbinom(4,4,3/4)


#例3.5:某批鸡种蛋的孵化率是0.9，从该批种蛋种每次任选5枚进行孵化，试求孵出小鸡的各种可能的概率。

P0=dbinom(0, 5, 0.9)
P1=dbinom(1, 5, 0.9)
P2=dbinom(2, 5, 0.9)
P3=dbinom(3, 5, 0.9)
P4=dbinom(4, 5, 0.9)
P5=dbinom(5, 5, 0.9)


#例3.6:某小麦品种在田间出现自然变异植株的概率是0.0045，试用二项分布计算：
#（1）调查100株，获得两株或两株以上变异植株的概率是多少？
#（2）期望有0.99的概率获得1株或1株以上变异植株，至少应该调查多少株？

#（1）
CP2_100=1-dbinom(0, 100, 0.0045)-dbinom(1, 100, 0.0045)
#得到CP2_100=0.07508
#（2）
size=seq(1,10000)
P=1-dbinom(0, size, 0.0045)
which.min(abs(P-0.99))
#求得size=1021时P最接近0.99



#例3.8:某小麦品种在田间出现自然变异植株的概率是0.0045，试用泊松分布计算：
#（1）调查100株，获得两株或两株以上变异植株的概率是多少？
#（2）期望有0.99的概率获得1株或1株以上变异植株，至少应该调查多少株？

#（1）
N=100
prob=0.0045
lambda=N*prob
CP2_100=1-dpois(0, lambda)-dpois(1,lambda)
#得到CP2_100=0.075439
#（2）
size=seq(1,10000)
P=1-dpois(0, size*prob)
which.min(abs(P-0.99))
#求得size=1023时P最接近0.99


#例3.9:设u服从正态分布N(0,1),试求：
#（1）P(u<=1)
#（2）P(u>1)
#（3）P(-2<u<=1.5)
#（4）P(|u|>2.58)

#（1）
P1=pnorm(1,mean = 0, sd = 1)
#或P1=pnorm(1,mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
#得到P1=0.8413
#（2）
P2=1-pnorm(1,mean = 0, sd = 1)
#得到P2=0.1586553
#（3）
P3=pnorm(1.5,mean = 0, sd = 1)-pnorm(-2,mean = 0, sd = 1)
#得到P3=0.9104427
#（4）
P4=pnorm(-2.58,mean = 0, sd = 1,lower.tail = T)+pnorm(2.58,mean = 0, sd = 1,lower.tail = F)
#得到P4=0.00988

