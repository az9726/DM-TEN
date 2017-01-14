# 决策树算法
# CART算法，处理的变量可以是离散的也可以是连续的。
# 使用rpart--计算/rpart.plot() --绘图

#准备原始数据
library(rpart) #rpart包中就有数据集 car.test.frame

#1加仑英里折算成百公里耗油升
car.test.frame$Mileage=100*4.546/(1.6*car.test.frame$Mileage) 

names(car.test.frame)=c("价格","产地","可靠性","油耗","类型","车重"
                        ,"发动机功率","净马力")


Group_Mileage=matrix(0,60,1)  #60行1列的0矩阵
Group_Mileage[which(car.test.frame$"油耗">=11.6)]="A"  
Group_Mileage[which(car.test.frame$"油耗"<=9)]="C"
Group_Mileage[which(Group_Mileage==0)]="B"
car.test.frame$"分组油耗"=Group_Mileage 
# car.test.frame[1:10,c(4,9)] 

#准备对原始数据进行分组抽样，使用sampling包

library(sampling)
a=round(1/4*sum(car.test.frame$"分组油耗"=="A")) #每类取四分之一
b=round(1/4*sum(car.test.frame$"分组油耗"=="B"))
c=round(1/4*sum(car.test.frame$"分组油耗"=="C"))
c(a,b,c) #每类数量

#不放回抽样（数据，分组字段，抽样数量，抽样方式 srswor--不放回/srswr--放回）
sub=strata(car.test.frame,stratanames="分组油耗",size=c(c,b,a),method="srswor") 


Train_Car=car.test.frame[-sub$ID_unit,] #学习组
Test_Car=car.test.frame[sub$ID_unit,] #测试组
nrow(Train_Car);nrow(Test_Car) # 45个样本/十五个样本

#数据准备end


######### 计 算 过 程 #########################################################

# 计算的是 油耗 对 价格、产地、可靠性、类型、车重、发动机功率、净马力 的分组
formula_Car_Reg=油耗~价格+产地+可靠性+类型+车重+发动机功率+净马力

#rpart(计算样式,数据集,模式) anova--连续的 class--离散的
#method ?
rp_Car_Reg=rpart(formula_Car_Reg,Train_Car,method="anova")

rp_Car_Reg

predict(rp_Car_Reg,car.test.frame) #根据决策树进行推断推断，
                                  #先是决策树，后是输入数据

##########一 些 参 数 #########################################################

#改变参数：minsplit--叶子节点的最小容量，这个数越小，生成的树就越大
#默认值是20
rp_Car_Reg1=rpart(formula_Car_Reg,Train_Car,method="anova",minsplit=10)

#改变参数：cp--复杂度参数,越小，树越大,默认0.01
rp_Car_Reg2=rpart(formula_Car_Reg,Train_Car,method="anova",cp=0.1)

#改变参数：maxdepth=1--层级参数,越大，树越大，在32位的系统中最大为30
rp_Car_Reg3=rpart(formula_Car_Reg,Train_Car,method="anova",maxdepth=10)

#数的复杂程度，有多参数共同决定
rp_Car_Reg4=rpart(formula_Car_Reg,Train_Car,method="anova",
                  maxdepth=10,cp=0.0001,minsplit=5)

printcp(rp_Car_Reg)
printcp(rp_Car_Reg1)
printcp(rp_Car_Reg3)
printcp(rp_Car_Reg4)


##########辅 助 命 令 #########################################################
print(rp_Car_Reg) #列出决策树
printcp(rp_Car_Reg) #列出 cp统计量 
summary(rp_Car_Reg) #列出更详细的情况

##########画 图 ###############################################################
library(rpart.plot)

rp_Car_Plot=rpart(formula_Car_Reg,Train_Car,method="anova",minsplit=10)
print(rp_Car_Plot)
rpart.plot(rp_Car_Plot)
rpart.plot(rp_Car_Plot,type=4) #type可以取(1,2,3,4),取4时显示最明晰
rpart.plot(rp_Car_Plot,type=4,branch=1) #线用直角联结
rpart.plot(rp_Car_Plot,type=4,fallen.leaves=TRUE) #所有层级的叶子节点排成一行

##############分类变量########################################################

formula_Car_Cla=分组油耗~价格+产地+可靠性+类型+车重+发动机功率+净马力
rp_Car_Cla=rpart(formula_Car_Cla,Train_Car,method="class",minsplit=5)
print(rp_Car_Cla)
rpart.plot(rp_Car_Cla,type=4,fallen.leaves=TRUE)

pre_Car_Cla=predict(rp_Car_Cla,Test_Car,type="class") #根据决策树统计
pre_Car_Cla
table(Test_Car$分组油耗,pre_Car_Cla)
(p=sum(as.numeric(pre_Car_Cla!=Test_Car$分组油耗))/nrow(Test_Car)) #测试集的错误率

