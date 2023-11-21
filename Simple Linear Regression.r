#clear environment
rm(list = ls())

set.seed(99)

#Import and read data
crimedata <- read.delim(file.choose(), header=TRUE)
head(crimedata)
str(crimedata)

#use regression model with lm
crimemodel <- lm(Crime~., data = crimedata)

#view the model
summary(crimemodel)

#build data frame with data
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

#Use data to predict how my model for crime works
hw_crimepredict <- predict(crimemodel, hwdataframe)
hw_crimepredict
