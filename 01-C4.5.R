#决策树算法
#C4.5 with packages (RWeka) 

library(RWeka)

summary(iris)

m1 <- J48(Species ~ ., data = iris)

m1

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
#         Correctly Classified Instances         147               98      %
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
# > plot(m1)
# > 
