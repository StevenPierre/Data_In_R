## Clear environment
rm(list = ls())

#Import and read data
library(datasets)
data(iris)
summary(iris)

library(ggplot2)
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) + geom_point()


kmeans(iris[, 1:4], centers = 2, nstart = 5)
# (between_SS / total_SS =  77.6 %)
kmeans(iris[, 1:4], centers = 3, nstart = 5)
#(between_SS / total_SS =  88.4 %)
kmeans(iris[, 1:4], centers = 4, nstart = 5)
#(between_SS / total_SS =  91.6 %)
kmeans(iris[, 1:4], centers = 5, nstart = 5)
#(between_SS / total_SS =  93.2 %)
kmeans(iris[, 1:4], centers = 6, nstart = 5)
# (between_SS / total_SS =  94.3 %)
kmeans(iris[, 1:4], centers = 7, nstart = 5)
# (between_SS / total_SS =  95.0 %)
kmeans(iris[, 1:4], centers = 8, nstart = 5)
# (between_SS / total_SS =  95.3 %)
kmeans(iris[, 1:4], centers = 9, nstart = 5)
# (between_SS / total_SS =  95.8 %)
kmeans(iris[, 1:4], centers = 10, nstart = 5)
#(between_SS / total_SS =  96.2 %)
kmeans(iris[, 1:4], centers = 11, nstart = 5)
# (between_SS / total_SS =  96.4 %)




