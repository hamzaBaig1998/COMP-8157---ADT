#Install pre-prequisite packagaes
install.packages("stats")
install.packages("dplyr", dependencies = TRUE)
install.packages("ggplot2")
install.packages("ggfortify")
#install.packages(c("cluster", "rattle","NbClust"))

# Load required libraries
library(stats)
library(dplyr)
library(ggplot2)
library(ggfortify)
#library(cluster)
#library(rattle)
#library(NbClust)

# To import a dataset
#mydata <- read.csv("iris.csv")
# To call the dataset
mydata <- iris
colnames(mydata)
View(mydata)
head(mydata)
head(mydata,15)
tail(mydata)


#dataset pre-processing
str(mydata)
dim(mydata)
summary(mydata)
class(mydata)

# To change the class type of the class variable 
# mydata$species <- as.factor(mydata$species)

# Find columns with missing values
colSums(is.na(mydata))
# Replace missing values with 0
mydata[(is.na(mydata))]<-0

#prepare for kmeans clustering
#Remove the labeled column (species)
data=select(mydata,c(1,2,3,4))
names(data)


## another method to remove a column -
#data$Species <- NULL
#data

#plot our kmeans clusters with different combination of 2 variables - 2 clusters
#to show the centriods you have to plot against 2 variables only
kmeans.result2 <- kmeans(data, 2) #2 clusters
kmeans.result2

#plot our kmeans clusters with different combination of 2 variables - 2 clusters
plot(data[c("Sepal.Length", "Sepal.Width")], col = kmeans.result2$cluster)

#to show the centriods you have to plot against 2 variables only
points(kmeans.result2$centers[,c("Sepal.Length", "Sepal.Width")], col = 1:3,  pch = 8, cex=2)

plot(data[c("Petal.Length", "Petal.Width")], col = kmeans.result2$cluster)
points(kmeans.result2$centers[,c("Petal.Length", "Petal.Width")], col = 1:3,  pch = 8, cex=2)

#to plot all variables together without trying different combination
plot(data, col = kmeans.result2$cluster)

#apply k-means clustering algorithm
kmeans.result3 <- kmeans(data, 3) #3 clusters
kmeans.result3

#plot our kmeans clusters with different combination of 2 variables - 2 clusters
#to show the centriods you have to plot against 2 variables only

plot(data[c("Sepal.Length", "Sepal.Width")], col = kmeans.result3$cluster)
points(kmeans.result3$centers[,c("Sepal.Length", "Sepal.Width")], col = 1:2,  pch = 8, cex=2)

plot(data[c("Petal.Length", "Petal.Width")], col = kmeans.result3$cluster)
points(kmeans.result3$centers[,c("Petal.Length", "Petal.Width")], col = 1:3,  pch = 8, cex=2)

#to plot all variables together without trying different combination
# Name in the row serves as the y-axis, name in the column serves as the x-axis  
plot(data, col = kmeans.result3$cluster)


#validate the performance of kmeans clustering because we already have labels for this dataset
#If we dont have a label for the dataset then this step is not needed.
table(iris$Species, kmeans.result3$cluster)

#wss Plot function - to choose the optimum number of clusters#
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")
  wss
}
wssplot(data)

#Show result in 3 dim
#library(ggplot2)

ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()
#kmeans.result3$cluster <- as.factor(kmeans.result3$cluster)
#ggplot(iris, aes(Petal.Length, Petal.Width, color = kmeans.result3$cluster)) + geom_point()

#cluster plot
autoplot(kmeans.result3,data,frame=TRUE)


##################################################################################################

