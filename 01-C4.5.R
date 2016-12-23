#决策树算法
#C4.5 with packages (RWeka) 

library(RWeka)

summary(iris)

m1 <- J48(Species ~ ., data = iris)

m1

table(iris$Species, predict(m1))

summary(m1)

plot(m1)


# > library(RWeka)  
# Warning message:
#         程辑包‘RWeka’是用R版本3.2.5 来建造的 
# > summary(iris)
# Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
# Species  
# setosa    :50  
# versicolor:50  
# virginica :50  
# 
# 
# 
# 
# > m1 <- J48(Species ~ ., data = iris)
# > m1
# J48 pruned tree
# ------------------
#         
# Petal.Width <= 0.6: setosa (50.0)
# Petal.Width > 0.6
# |   Petal.Width <= 1.7
# |   |   Petal.Length <= 4.9: versicolor (48.0/1.0)
# |   |   Petal.Length > 4.9
# |   |   |   Petal.Width <= 1.5: virginica (3.0)
# |   |   |   Petal.Width > 1.5: versicolor (3.0/1.0)
# |   Petal.Width > 1.7: virginica (46.0/1.0)
# 
# Number of Leaves  : 	5
# 
# Size of the tree : 	9
# 
# > summary(m1)
# 
# === Summary ===
#         
# Correctly Classified Instances         147               98      %
# Incorrectly Classified Instances         3                2      %
# Kappa statistic                          0.97  
# Mean absolute error                      0.0233
# Root mean squared error                  0.108 
# Relative absolute error                  5.2482 %
# Root relative squared error             22.9089 %
# Total Number of Instances              150     
# 
# === Confusion Matrix ===
#         
#  a  b   c   <-- classified as
# 50  0   0 |  a = setosa
# 0   49  1 |  b = versicolor
# 0   2  48 |  c = virginica
# 
# > table(iris$Species, predict(m1))  #view the result 
# 
#             setosa versicolor virginica
# setosa         50          0         0
# versicolor      0         49         1
# virginica       0          2        48
# 
# > plot(m1)
# > 
# 正式使用时会发现这个现象，输入的数据是100条，但是输出的数据结果不足一百条，用rpart包中的数据car.test.frame进行试验可以看到结果
#> nrow(Train_Car);nrow(Test_Car)
#[1] 45
#[1] 15
#> formula=Oil_Consumption~Price+Country+Reliability+Type+Weight+Disp.+HP
#> C45_0=J48(formula,Train_Car)
#> summary(C45_0)
#
#=== Summary ===
#
#Correctly Classified Instances          32               88.8889 %
#Incorrectly Classified Instances         4               11.1111 %
#Kappa statistic                          0.811 
#Mean absolute error                      0.1093
#Root mean squared error                  0.2338
#Relative absolute error                 27.6786 %
#Root relative squared error             52.8652 %
#Total Number of Instances               36     
#
#=== Confusion Matrix ===
#
#  a  b  c   <-- classified as
# 20  0  0 |  a = A
#  1  6  3 |  b = B
#  0  0  6 |  c = C
#Train_Car中有45条数据，结果中只有“Total Number of Instances               36     ”，可能和“剪枝”有关。
#结果的检验分析可以使用这个命令
#> table(Train_Car$Oil_Consumption,predict(C45_0,Train_Car))
#   
#     A  B  C
#  A 25  1  0
#  B  1  8  3
#  C  0  0  7