# �������㷨
# CART�㷨�������ı�����������ɢ��Ҳ�����������ġ�
# ʹ��rpart--����/rpart.plot() --��ͼ

#׼��ԭʼ����
library(rpart) #rpart���о������ݼ� car.test.frame

#1����Ӣ������ɰٹ��������
car.test.frame$Mileage=100*4.546/(1.6*car.test.frame$Mileage) 

names(car.test.frame)=c("�۸�","����","�ɿ���","�ͺ�","����","����"
                        ,"����������","������")


Group_Mileage=matrix(0,60,1)  #60��1�е�0����
Group_Mileage[which(car.test.frame$"�ͺ�">=11.6)]="A"  
Group_Mileage[which(car.test.frame$"�ͺ�"<=9)]="C"
Group_Mileage[which(Group_Mileage==0)]="B"
car.test.frame$"�����ͺ�"=Group_Mileage 
# car.test.frame[1:10,c(4,9)] 

#׼����ԭʼ���ݽ��з��������ʹ��sampling��

library(sampling)
a=round(1/4*sum(car.test.frame$"�����ͺ�"=="A")) #ÿ��ȡ�ķ�֮һ
b=round(1/4*sum(car.test.frame$"�����ͺ�"=="B"))
c=round(1/4*sum(car.test.frame$"�����ͺ�"=="C"))
c(a,b,c) #ÿ������

#���Żس��������ݣ������ֶΣ�����������������ʽ srswor--���Ż�/srswr--�Żأ�
sub=strata(car.test.frame,stratanames="�����ͺ�",size=c(c,b,a),method="srswor") 


Train_Car=car.test.frame[-sub$ID_unit,] #ѧϰ��
Test_Car=car.test.frame[sub$ID_unit,] #������
nrow(Train_Car);nrow(Test_Car) # 45������/ʮ�������

#����׼��end


######### �� �� �� �� #########################################################

# ������� �ͺ� �� �۸񡢲��ء��ɿ��ԡ����͡����ء����������ʡ������� �ķ���
formula_Car_Reg=�ͺ�~�۸�+����+�ɿ���+����+����+����������+������

#rpart(������ʽ,���ݼ�,ģʽ) anova--������ class--��ɢ��
#method ?
rp_Car_Reg=rpart(formula_Car_Reg,Train_Car,method="anova")

rp_Car_Reg

predict(rp_Car_Reg,car.test.frame) #���ݾ����������ƶ��ƶϣ�
                                  #���Ǿ�������������������

##########һ Щ �� �� #########################################################

#�ı������minsplit--Ҷ�ӽڵ����С�����������ԽС�����ɵ�����Խ��
#Ĭ��ֵ��20
rp_Car_Reg1=rpart(formula_Car_Reg,Train_Car,method="anova",minsplit=10)

#�ı������cp--���ӶȲ���,ԽС����Խ��,Ĭ��0.01
rp_Car_Reg2=rpart(formula_Car_Reg,Train_Car,method="anova",cp=0.1)

#�ı������maxdepth=1--�㼶����,Խ����Խ����32λ��ϵͳ�����Ϊ30
rp_Car_Reg3=rpart(formula_Car_Reg,Train_Car,method="anova",maxdepth=10)

#���ĸ��ӳ̶ȣ��ж������ͬ����
rp_Car_Reg4=rpart(formula_Car_Reg,Train_Car,method="anova",
                  maxdepth=10,cp=0.0001,minsplit=5)

printcp(rp_Car_Reg)
printcp(rp_Car_Reg1)
printcp(rp_Car_Reg3)
printcp(rp_Car_Reg4)


##########�� �� �� �� #########################################################
print(rp_Car_Reg) #�г�������
printcp(rp_Car_Reg) #�г� cpͳ���� 
summary(rp_Car_Reg) #�г�����ϸ�����

##########�� ͼ ###############################################################
library(rpart.plot)

rp_Car_Plot=rpart(formula_Car_Reg,Train_Car,method="anova",minsplit=10)
print(rp_Car_Plot)
rpart.plot(rp_Car_Plot)
rpart.plot(rp_Car_Plot,type=4) #type����ȡ(1,2,3,4),ȡ4ʱ��ʾ������
rpart.plot(rp_Car_Plot,type=4,branch=1) #����ֱ������
rpart.plot(rp_Car_Plot,type=4,fallen.leaves=TRUE) #���в㼶��Ҷ�ӽڵ��ų�һ��

##############�������########################################################

formula_Car_Cla=�����ͺ�~�۸�+����+�ɿ���+����+����+����������+������
rp_Car_Cla=rpart(formula_Car_Cla,Train_Car,method="class",minsplit=5)
print(rp_Car_Cla)
rpart.plot(rp_Car_Cla,type=4,fallen.leaves=TRUE)

pre_Car_Cla=predict(rp_Car_Cla,Test_Car,type="class") #���ݾ�����ͳ��
pre_Car_Cla
table(Test_Car$�����ͺ�,pre_Car_Cla)
(p=sum(as.numeric(pre_Car_Cla!=Test_Car$�����ͺ�))/nrow(Test_Car)) #���Լ��Ĵ�����
