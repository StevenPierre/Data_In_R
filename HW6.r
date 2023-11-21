#clear environment
rm(list = ls())

set.seed(99)

#Import and read data
crimedata <- read.delim(file.choose(), header=TRUE)
head(crimedata)
str(crimedata)

#apply principal component analysis
crimedata_pca <- prcomp(crimedata[, -16], center = TRUE, scale. = TRUE)
summary(crimedata_pca)

##plot the results of the principal component analysis...cause I like visuals
screeplot(crimedata_pca, main = 'Scree Plot', type = 'lines')

#Prepare first 5 componenets for model 
crimedata_pca_select <- cbind(crimedata_pca$x[,1:5], crimedata[,16])
str(crimedata_pca_select) 

#Turn new subset of data into a dataframe for use in the model
crimedata_pca_select <- as.data.frame(crimedata_pca_select)
str(crimedata_pca_select)

#create regression model using the first 5 components
crimedatapca_model <- lm(V6~., data = crimedata_pca_select)
summary(crimedatapca_model)

#Need to convert the terms for our actual new model to compare it against last weeks model
intercept <- crimedatapca_model$coefficients[1]
beta <- crimedatapca_model$coefficients[2:6]

alpha <- crimedata_pca$rotation[,1:5] %*% beta
alpha

intercept

#Time to unscale the components in our model 
mu <- crimedata_pca$center
sd <- crimedata_pca$scale

ahh <- alpha/sd
b <- intercept - sum(alpha*mu/sd)
ahh
b

#Make estimates and calculate R2 and adjusted R2 to compare to last week's answer
estimate <- as.matrix(crimedata[,1:15]) %*% ahh + b
sse = sum((estimate - crimedata[,16])^2)
sstot = sum((crimedata[,16] - mean(crimedata[,16]))^2)
r2 <- 1 - sse/sstot
r2

#Got an R2 of 64.51%. Let's see how it compares to last week
hwdataframe <- data.frame(M = 14.0, 
                          So = 0,
                          Ed = 10.0,
                          Po1 = 12.0,
                          Po2 = 15.5,
                          LF = 0.640,
                          M.F = 94.0,
                          Pop = 150,
                          NW = 1.1,
                          U1 = 0.120,
                          U2 = 3.6,
                          Wealth = 3200,
                          Ineq = 20.1,
                          Prob = 0.04,
                          Time = 39.0
)
hw5_pred <- data.frame(predict(crimedata_pca, hwdataframe))

hw6_pred <- predict(crimedatapca_model, hw5_pred)

hw6_pred
