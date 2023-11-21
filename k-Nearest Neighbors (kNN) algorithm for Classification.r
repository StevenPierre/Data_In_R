#clear environment
rm(list = ls())

library(kknn)
#data import
CCdata <- read.delim(file.choose(), header=FALSE)
#looking at the top 6 rows
head(CCdata)
#looking at the structure
str(CCdata)

set.seed(99)
#Getting the number of rows in my data
row_count <- nrow(CCdata)
#randomly shuffling/reordering the rows 
shuffled_rows <- sample(row_count)

#Splitting data into a train and test set.
CC_Train <- CCdata[head(shuffled_rows,floor(row_count*0.70)),]
CC_Test <- CCdata[tail(shuffled_rows,floor(row_count*0.30)),]

knn_predicted <- rep(0, 457)

#created an empty table to later put the predication/accuracy values into
Train_table = NULL
str(Train_table)

#loop that runs through 20 K values from 3 to 23 to find the best one
for (n in 3:23){
  for(i in 1:nrow(CC_Train)){
    CC_Train_model=kknn(V11~.,
                        CC_Train[-i,],
                        CC_Train[i,],
                        k=n, 
                        scale = TRUE, 
                        kernel = 'optimal'
    )
    
    knn_predicted[i] <- as.integer(fitted(CC_Train_model)+0.5)
    
  }
  pred1 = sum(knn_predicted == CC_Train[, 11]) / nrow(CC_Train)
  Train_table = rbind(Train_table, data.frame(k=n, prediction_rate = pred1))
}

#output table with the k values and corresponding prediction rate
Train_table

#max prediction value
max(Train_table$prediction_rate)

## Testing the best K value on the test data set
full_knn_predicted <- rep(0,196)

Full_table = NULL


  CC_model_full = kknn(V11~.,
                             CC_Train,
                             CC_Test,
                             k = 11,
                             scale = TRUE, 
                             kernel = 'optimal'
  )
  
  full_knn_predicted <- as.integer(fitted(CC_model_full)+0.5)


Test_prediction = sum(full_knn_predicted == CC_Test[, 11])/ nrow(CC_Test)
Test_prediction

Full_table = rbind(Full_table, data.frame(k=11, prediction_rate = Test_prediction))
Full_table
