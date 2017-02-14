#练习k-means方法，列表的使用，for循环，高水平及低水平画图，点的形状，大小、颜色等

##("Hartigan-Wong", "Lloyd", "Forgy","MacQueen")四种距离的具体含义还需要继续明确
##变量是否要进行标准化，还远哦继续学习。

#生成测试用数据
library(stats)
z<-data.frame(rnorm(100,10,10),rnorm(100,20,20))

kz1<-kmeans(z,2)

colnames(z)<-c('x','y')
# 

# 
# a<-list(0)
# b<-a
# for (n in (1:10)) {
#         c<-(kmeans(z,5))
#         a[[n]]<-c$centers
#         b[[n]]<-c$withinss
# }
# # plot()
# # points(a[[1]])
# # plot(as.data.frame(a[[1]]))

w<-list(0)

for (n in (1:10)) {
       
        w[[n]]<-kmeans(z,5,nstart=1,iter.max=n^2 ) #5--分成5簇
        #item--最大迭代次数，默认是10，次数越多，结果越收敛
        #nstart--计算次数,默认为1，
        #网上建议取20~25，具体含义不太明确，认为取的大一些结果越集中
}
plot(w[[1]]$centers,pch=1,cex=1,col=1)
for (n in (2:length(w))) {
       points(w[[n]]$centers,pch=n,cex=1,col=n)
}


par(mfrow=c(3, 4))
for (n in (1:length(w))) {
        plot(w[[n]]$centers,pch=n,cex=1,col=n,main =w[[n]]$tot.withinss)
}
par(mfrow=c(1, 1))


kk<-list()
#algorithm = c("Hartigan-Wong", "Lloyd", "Forgy","MacQueen")
kk[[1]]<-kmeans(z,5,nstart=10,algorithm = c("Hartigan-Wong") )
kk[[2]]<-kmeans(z,5,nstart=10,algorithm = c("Lloyd") )
kk[[3]]<-kmeans(z,5,nstart=10,algorithm = c("Forgy") )
kk[[4]]<-kmeans(z,5,nstart=10,algorithm = c("MacQueen") )

par(mfrow=c(2, 2))
plot(kk[[1]]$centers)
plot(kk[[2]]$centers)
plot(kk[[3]]$centers)
plot(kk[[4]]$centers)


par(mfrow=c(1, 1))

plot(kk[[1]]$centers,pch=1,col=1)
points(kk[[2]]$centers,pch=13,col=13)
points(kk[[3]]$centers,pch=15,col=5)
points(kk[[4]]$centers,pch=17,col=17)

plot(z,cex=0.5)  #作图
points(kk[[2]]$centers,pch=21,cex=2,col=5) #填上中心点
points(kk[[1]]$centers,pch=21,cex=4,col=9)
points(kk[[3]]$centers,pch=21,cex=1,col=2)
points(kk[[4]]$centers,pch=21,cex=5,col=7)

# text(10, 10, "CCCCC")
# 
# text(kk[[2]]$centers,"A")

text(kk[[2]]$centers,labels =  kk[[2]]$size) #添加该簇包含的元素个数。


