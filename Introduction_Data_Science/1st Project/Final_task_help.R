# Import the file with the data
load("titanic_train.RDATA")
#aux is the number of people that doesn't travel with parents neither siblings or spouse
aux = titanic.train$Parch == 0 & titanic.train$SibSp == 0
sum(aux)
#Create a frame that sais if people travel alone or not 
travels_alone = rep("NO",length(aux))
travels_alone[aux]="YES"
#Add this information to the principal data 
titanic.train = cbind(titanic.train, travels_alone)
View(titanic.train)
#Create a table with frequencies of the people that survive and travel alone. The matgin one
#implies that the sum of frequencies of each line = 1 
prop.table(table(titanic.train$travels_alone, titanic.train$Survived), margin=1)

install.packages("ggplot2")
library("ggplot2")
#ggplot to say where you take the data, aes yto say how the dta is place and geom_bar put it like you want 
ggplot(data=titanic.train)+ aes(x=travels_alone, 
                                fill = Sex) + geom_bar(position = position_fill())

