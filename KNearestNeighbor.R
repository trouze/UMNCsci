require(class) # needed for knn()
require(ISLR) # needed for Default data set
require(tidyverse)

# split data into training set 8000 points and 2000 for test set
Def <- Default
Def$student <- ifelse(Def$student=="No", 0, 1)

Def.scaled <- scale(Def[,2:4])
n <- nrow(Def)
train <- sample(1:n, 8000)
test <- setdiff(1:n, train)

train.X <- Def.scaled[train,]
train.Y <- Def$default[train]
test.X <- Def.scaled[test,]
test.Y <- Def$default[test]

## data is scaled!
knn.pred <- knn(train.X, test.X, train.Y, k=5)
tbl <- table(knn.pred, test.Y)

## compute quantities
## overall error rate
overall.err <- (tbl[2,1]+tbl[1,2])/(sum(tbl[1:2,1:2]))
## false positive rate
false.pos <- tbl[2,1]/(tbl[2,1]+tbl[1,1])
## false negative rate
false.neg <- tbl[1,2]/(tbl[1,2]+tbl[2,2])

## plot it!
DefPlot <- Default
DefPlot <- cbind(DefPlot,test.Y)
DefPlot <- slice(DefPlot,test)

myColors <- c("red", "blue")
myShapes <- c(0,1)
mySizes <- c(2,12)
ggplot(DefPlot,aes(x=income, y=balance, color=as.factor(default), size=as.factor(test.Y), shape=as.factor(student))) +
  geom_point() +
  labs(x="Income", y="Balance", title="Credit Card Default Data") +
  scale_color_manual(name="Default", values=myColors) +
  scale_size_manual(name="False Negative", values=mySizes) +
  scale_shape_manual(name="Student", values=myShapes)










