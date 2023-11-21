#clear environment
rm(list = ls())

set.seed(99)

library(kernlab)

#Load data and take a look at some descriptive stats
data <- read.table("C:/Users/Steven/Documents/GT Introduction to Analytics Modeling/hw10-Fall_21/data 14.1/breast-cancer-wisconsin.data.txt", stringsAsFactors = FALSE, header=FALSE, sep=",")
head(data)
str(data)
summary(data)

#Look for missing values
for (i in 2:11){
  print(paste0("V",i))
  print(table(data[,i]))
}

# V7 has a ? so that means some values are missing there
#Let's look at which data is missing there
data[which(data$V7 =="?"),]
missing<- which(data$V7 =="?", arr.ind = TRUE)

#find the % of missing data 
nrow(data[which(data$V7 =="?"),])/nrow(data)

#Use the mean for V7
imputedata <- which(data$V7 == "?")
clean = data[-imputedata,]
partial = data[imputedata,]

meanV7 = round(mean(as.integer(clean$V7)))
mean_data <- data
mean_data$V7[imputedata] = as.factor(meanV7)
mean_data <- droplevels(mean_data)
print(mean_data$V7[imputedata])


#Point 2, try using regression
#new dataset
data_edit <- data[-missing, 2:10]

#Use linear regression
model <- lm(V7~., data_edit)
summary(model)
step(model)

regression_impute <- predict(model, new_data = data[missing,])
regression_impute

install.packages("mice")

#Point 3, use regression with pertubation
regression_impute_pert <- rnorm(length(missing), regression_impute, sd(regression_impute))
regression_impute_pert

data_pertubation <- data
data_pertubation[missing,]$V7 <- regression_impute_pert
data_pertubation$V7 <- as.numeric(data_pertubation$V7)


