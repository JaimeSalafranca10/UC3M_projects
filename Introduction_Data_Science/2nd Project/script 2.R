# We first remove all the the variables.
rm(list=ls())

# We import the data 
load("titanic_train.Rdata")

#And we visualize it.
View(titanic.train)

#In order to clean the values we have to:
#change to numbers the values of sex and embarked
#We have to remove the variable Ticket that is non-sense to our study.
#The variable cabine has a lot of missing values so we judge that it cannot 
#be used to the study.

#We change the variable embarked :
titanic.train$Embarked= factor(titanic.train$Embarked, 
                               levels=c("C","S", "Q"),
                               labels=c(1,2,3))
titanic.train$Embarked = as.numeric(titanic.train$Embarked)

#We do the same for the Sex:
titanic.train$Sex = factor(titanic.train$Sex,
                           levels = c("male", "female"),
                           labels= c(1,2))


titanic.train$Sex = as.numeric(titanic.train$Sex)

#We change the  values of survived to True and False because it is the variable of reference.
titanic.train$Survived = factor(titanic.train$Survived,levels = c(1,0),labels=c(TRUE,FALSE))

titanic.train$Pclass = as.numeric(titanic.train$Pclass)
#We erase the values of the ticket that aren't usefull.
titanic.train[,"Ticket"]=NULL
#We do the same for the Cabin
# Remove the data since we have no clear criteria to fulfill the information and the number of 
# missing records is great with respect to sample size
titanic.train[,"Cabin"]=NULL

means = apply(X=titanic.train[,2:8], MARGIN = 2, FUN = mean)
stdvs  = apply(X=titanic.train[,2:8], MARGIN = 2, FUN = sd)
titanic.train_standarized = titanic.train
titanic.train_standarized[,2:8] = sweep(sweep(titanic.train[,2:8], STATS = means, MARGIN = 2, FUN = "-" ),
                                        STATS = stdvs, MARGIN = 2, FUN = "/" )



library(rpart)
#=================FIRST CLASSIFICATION TREE=====================================
n = nrow(titanic.train_standarized)
idx = sample(1:n, floor(n*0.8))
train = titanic.train_standarized[idx,]
test = titanic.train_standarized[-idx,]
tree = rpart(formula = Survived~., data = train, method = "class")
pred = predict(tree, test, type = "class")
conf_matrix = table(test$Survived ,pred,dnn=c("Actual value","Classifier prediction"))
library("rpart.plot")  
prp(tree,
    type=2,
    extra=106,
    nn=TRUE,
    shadow.col="blue",
    digits=2,
    roundint=FALSE)

#==================REPEATED VALIDATION==========================================
library(caTools)
set.seed(123)
nrep = 100

splits = replicate(nrep, sample.split(titanic.train$Survived, SplitRatio = 0.8),
                  simplify = FALSE)
cv = lapply(splits, function(x) {
  # Select training and test set according to current split
  training_set = subset(titanic.train, x == TRUE)
  test_set = subset(titanic.train, x == FALSE)
  mytree=rpart(formula=Survived ~., data=training_set, method="class")
  # Use the function predict to apply the classification algorithm
  # with test set
  pred = predict(mytree,test_set,type="class")
  # Compute the confusion matrix
  conf_matrix = table(test_set$Survived,pred,dnn=c("Actual value","Classifier prediction"))
  conf_matrix_prop = prop.table(conf_matrix)
  
  # Compute error estimates
  accuracy = sum(diag(conf_matrix))/sum(conf_matrix)
  precision = conf_matrix[1,1]/sum(conf_matrix[,1])
  specificity = conf_matrix[2,2]/sum(conf_matrix[,2])
  return(c(accuracy,precision,specificity))
})
cv = t(matrix(unlist(cv),nrow=3))
colnames(cv)=c('Accuracy','Precision','Specificity')

accuracies = apply(X=cv,MARGIN=2,FUN = "mean")


