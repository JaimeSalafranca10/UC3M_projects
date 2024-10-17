# We first remove all the the variables.
rm(list=ls())

#First we import the libraries we are going to use
library(ggplot2)
library(lattice)
library(caret)
library(rpart)

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


#We do the same for the Sex(It is optional in this case ):
titanic.train$Sex = factor(titanic.train$Sex,
                        levels = c("male", "female"),
                        labels= c(1,2))


#We change the  values of survived to Survived and DIED because it is the variable 
#of reference.(we could change it by True or False)
titanic.train$Survived = factor(titanic.train$Survived,
                                levels = c(1,0),labels=c("SURVIVED","DIED"))


#We erase the values of the ticket that aren't useful.
titanic.train[,"Ticket"]=NULL
#We do the same for the Cabin
# Remove the data since we have no clear criteria to fulfill the information 
#and the number of missing records is great with respect to sample size
titanic.train[,"Cabin"]=NULL



#=========HERE WE DEFINE THE STANDARIZATION BUT IT IS NOT NEEDED AT THE END=======
#here we do the code to standardize the data in our case
#This is not useful in our work but it can be useful to verify 
#the accuracy.
titanic.train$Embarked = as.numeric(titanic.train$Embarked)
titanic.train$Sex = as.numeric(titanic.train$Sex)
titanic.train$Pclass = as.numeric(titanic.train$Pclass)

means = apply(X=titanic.train[,2:8], MARGIN = 2, FUN = mean)
stdvs  = apply(X=titanic.train[,2:8], MARGIN = 2, FUN = sd)
titanic.train_standarized = titanic.train
titanic.train_standarized[,2:8] = sweep(sweep(titanic.train[,2:8],
                                              STATS = means, MARGIN = 2, 
                                              FUN = "-" ),
                           STATS = stdvs, MARGIN = 2, FUN = "/" )


#=======================WE USE HYPERPARAMETERS FOR THE TREE=====================
#We can use a seed 
set.seed(145)

# Applying k-Fold Cross Validation
folds = createFolds(titanic.train$Survived, k = 10)

# We train our classification tree using function r part
#We create the parameters to the hyper parameters research for the best model(tree)
d_minsplit=seq(from=10, to= 100,by=10)
d_maxdepth = seq(from=1, to = 30, by = 1)
d_cp = 2^(-11:-1)
paramet= expand.grid(d_minsplit, d_maxdepth, d_cp)


#With this function we test the hyperparameters
cv_hyper = apply(paramet, 1, function(y){
  cv = lapply(folds, function(x) {
    
    # We select training and test set according to the k-cross Validation
    training_set = titanic.train[-x,]
    test_set = titanic.train[x,]
    #We built the tree 
    mytree=rpart(formula=Survived ~.,
                 data=training_set, method="class", 
                 control = rpart.control(minsplit = 
                                           y[1], maxdepth = y[2], cp = y[3]))
    #With the pred() we tree to predict the variable Survived
    pred = predict(mytree,test_set,type="class")
    # Compute the confusion matrix, to verify the accuracy
    conf_matrix = table(test_set$Survived,pred,
                        dnn=c("Actual value","Classifier prediction"))
    conf_matrix_prop = prop.table(conf_matrix)
    
    # We compute the accuracy precision and specificity even if they 
    #not all interest us
    accuracy = sum(diag(conf_matrix))/sum(conf_matrix)
    precision = conf_matrix[1,1]/sum(conf_matrix[,1])
    specificity = conf_matrix[2,2]/sum(conf_matrix[,2])
    return(c(accuracy,precision,specificity))
  }) 
  cv = t(matrix(unlist(cv),nrow=3))
  accuracies = apply(X=cv,MARGIN=2,FUN = "mean")
  return(accuracies)
})

#here we see the accuracy in function of the hyper parameters 
accuracy = cv_hyper[1,]
plot(accuracy)

#We see the best accuracy 
cv_hyper[1, which.max(cv_hyper[1, ])]
max(cv_hyper[1, ])

#We take the parameters of the model with the best:
#Accuracy
acc = paramet[which.max(cv_hyper[1, ]),]

#Here the precision and the specificity doesn't interest us because we had 
#decided like this. But it is interesting to verify this data.

#Precision
paramet[which.max(cv_hyper[2, ]),]
#Specificity
paramet[which.max(cv_hyper[3, ]),]  



#Now we can plot the tree with the parameters of the best accuracy.
library(rpart.plot) 
#We create the tree with the best hyper parameters
mytree=rpart(formula=Survived ~., data=titanic.train, method="class",
             control = rpart.control(minsplit = acc[,1], maxdepth = acc[,2], cp = acc[,3]))

#We plot the tree
prp(mytree, type=2, 
    extra=106, box.col = c("palegreen3","pink" )[mytree$frame$yval],
    nn=TRUE, 
    shadow.col="black", digits=2, roundint=FALSE)




#==========================RANDOM FOREST========================================


#Here we transform the varriable Survived in True or False.
titanic.train$Survived = factor(titanic.train$Survived,
                                levels = c("SURVIVED","DIED"),
                                labels=c(TRUE , FALSE))


# Applying k-Fold Cross Validation
library(randomForest)
set.seed(15)
# We train our classification random forest using function randomForest


# We select the Hyper parameter 
#The numbers of variables is 7 so we can do  it until 6
d_mtry=seq(from=2,to=6,by=1)
d_ntree=seq(from=100,to=800,by=50)
parameters = expand.grid(mtry=d_mtry,ntree=d_ntree)

# Create the folds
nfold = 10
n = nrow(titanic.train)
folds = sample(rep(1:nfold,length.out=n))

# Create the matrix for storing the values of accuracy of each model 
# in each iteration
accuracies = matrix(NA,nfold,nrow(parameters))

for (i in 1:nfold){
  # Split into train and test, here we do it in another way
  train = titanic.train[folds != i,]
  test = titanic.train[folds == i,]
  
  # Fit and evaluate every model
  for (j in 1:nrow(parameters)){
    rf = randomForest(Survived~.,train,mtry = parameters$mtry[j],
                      ntree = parameters$ntree[j])
    #We use the function pred() 
    pred = predict(rf,test,type="class")
    
    accuracies[i,j]  = sum(pred == test$Survived)/length(pred)
  }
}

parameters$acc = apply(accuracies,2,mean)
#We can plot the accuracy in function of the different hyperparameters
ggplot(parameters) + aes(x = mtry, y = acc, color=as.factor(ntree)) + geom_line(size=1) + geom_point(size=3) + 
  theme(text = element_text(size=14)) + labs(color="No. of trees",y = "Accuracy", x = "No. of variables")

#We can also use the plot of accuracy to have a first impression
accuracy = parameters$acc
plot(accuracy)

# acc are the parameters for the most accurate random forest
acc = parameters[which.max(parameters$acc),]
#We create th best random forest with the parameters of the best hyper parmeters
bestclassifier = randomForest(formula = Survived~., 
                              data = titanic.train , mtry = acc[,1] , ntree = acc[,2])

#We can even plot the errors.
plot(bestclassifier)


#We create the model to test a set of data with our best classifier.
mymodel = function(test_set){
  #We clean the data inside the function
  test_set$Embarked= factor(test_set$Embarked, 
                                 levels=c("C","S", "Q"),
                                 labels=c(1,2,3))
  test_set$Sex = factor(test_set$Sex,
                             levels = c("male", "female"),
                             labels= c(1,2))
  test_set$Survived = factor(test_set$Survived,
                              levels = c(1,0),labels=c(TRUE, FALSE))
  test_set[,"Cabin"]=NULL
  test_set[,"Ticket"]=NULL
  
  pred = predict(bestclassifier, test_set, type = "class")
  conf_matrix = table(test_set$Survived,pred,
                      dnn=c("Actual value","Classifier prediction"))
  conf_matrix_prop = prop.table(conf_matrix)
  accuracy = sum(diag(conf_matrix))/sum(conf_matrix)
  precision = conf_matrix[1,1]/sum(conf_matrix[,1])
  specificity = conf_matrix[2,2]/sum(conf_matrix[,2])
  return(list(prediction = pred, conf_matrix = conf_matrix, accuracy))
}

#Finnally we save the model in order to be able to use it.
save(bestclassifier, mymodel, file = "BestModel.RData")


