remove(list=ls())
library("ggplot2")
library("writexl")
load("titanic_train.RDATA")
View(titanic.train)

#In this script the graph variables and tables are done in the same order that in the answer pdf 
#Each question has the same number that in the pdf to find quickly each line.
#We have let the step we have done with some graph that we finded not clear enouth for you to understand thewhole procedure. 


#1.1 We create a proportions table of the survivals and then we plot a bar chart

survivors = titanic.train$Survived ==1
prop_survivors= prop.table(table(survivors))
rownames(prop_survivors)= c("Died", "Survived")
prop_survivors=data.frame(prop_survivors)
prop_survivors 


ggplot(data=titanic.train) + aes(x=Survived) + geom_bar(fill=c("black","white"),
                                                        colour = "black") + ylab("People")



#1.2 Now we are going to do the same thing for the different classes
prop_Pclass = prop.table(table(titanic.train$Pclass))

ggplot(data=titanic.train) + aes(x=Pclass)+ geom_bar(fill=c("lightgreen", "darkolivegreen4", "darkgreen"),
                                                     colour= "black") + ylab("People")+ xlab("Class in croissant order")


#1.3Now we do the same thing (prop.table and bar chart) for the gender===========================
prop_gender = data.frame(prop.table(table(titanic.train$Sex)))
prop_gender


ggplot(data=titanic.train) + aes(x=Sex) + geom_bar(fill=c("pink", "blue"),
                                                   colour= "black",) + ylab("People")

#1.4 Now we are going to do the same thing for the port of embarkation
prop_port = data.frame(prop.table(table(titanic.train$Embarked)))


ggplot(data=titanic.train) + aes(x=Embarked)+ geom_bar(fill=c("lightsalmon4", "lightgreen", "lightcoral"),
                                                       colour= "black")+ ylab("People")


#We consider the values with numerical discrete data like categorical data

#1.5 We do the same thing for the spouse or siblings
prop_SpouseAndAsiblings = prop.table(table(titanic.train$SibSp))

#we did the summary but it is not as good for showing the data as a frequency table.
summary(titanic.train$SibSp)

ggplot(titanic.train)+ aes(x=SibSp) + geom_bar( colour="black", fill = "lavender" ) + ylab("People")



#1.6 We do the same thing for the children and parents
summary(titanic.train$Parch)

prop_ChildrenAndParents = prop.table(table(titanic.train$Parch))

ggplot(titanic.train) + aes(x=Parch) + geom_bar( fill="bisque3", colour="black") + xlab("Parents or children") + ylab("People")
#1.7 Now we are doing to do it with ages creating intervals of 5 years

#We started doing a prop table and a histogram for some intervals but we changed it by a density curve
#summary
prop_age= prop.table(table(cut(titanic.train$Age,breaks=15, labels=FALSE,right=TRUE )))
rownames(prop_age)= c("[0,5)","[5,10)","[10,15)","[15,20)","[20,25)","[25,30)","[30,35)",
                      "[35,40)","[40,45)","[45,50)","[50,55)","[55,60)","[60,65)","[65,70)","[70,75)")
prop_age  

ggplot(data=titanic.train) + aes(x=Age)+ geom_histogram(bins=15, fill="White",
                                                        colour="black",aes(y=..density..))


#The curve and summary
summary(titanic.train$Age)
ggplot(data=titanic.train) + aes(x=Age)+ geom_density(fill="cornsilk",
                                                      colour="black")



#1. 8. Finally we do that for the price with a boxplot
summary(titanic.train$Fare)

ggplot(data=titanic.train) + aes(x=Fare)+geom_boxplot(colour="brown")

#Here also we did a histogram but it was less useful.

ggplot(titanic.train) + aes(x=Fare) + geom_histogram(bins=20,colour="black", fill="blue", aes(y=..density..))



#We can do it for the first letter of the cabin 
#We tried to do something with the cabins but we were unable to finish.

cab=titanic.train$Cabin
table(cab)
ggplot(titanic.train)+ aes(x=Cabin)+ geom_bar()


#Mixed questions________________________________________________________________________________________________________________________---

#2.1 We create a variable for children to work only with children data
child= which(titanic.train$Age<18)
aa= data.frame(titanic.train[child,])
length(child)

#2.1 .1we decide to look if there was more or less the same amount of girls and boys
png(file="2.1.png")
ggplot(data=aa) + aes(x=Sex)+ geom_bar(colour = "black" ,fill=c("pink","blue"))
dev.off()


#2.1.2  We search what were the chances to survive for children in fonction of there genre

ggplot(data=aa) + aes(x=Survived, fill= Sex)+
  geom_bar(position= "fill",colour = "black") + scale_fill_manual(values=c("pink","blue"))+ xlab(c("Died","Survived"))


#2.1.3.  After that we look for the difference in the survival by age and by genre.


ggplot(data=aa) + aes(x=Age, fill=Survived) +
  geom_histogram(bins=6, colour="black", position="fill")+ 
  facet_grid(Sex~.)+scale_fill_manual(values=c("white","coral1"))




#2.2. Question 2 

#2.2.1.  we look for the chances of survive in function of the number of parents.
#Here we use the same variable that we used before
#And take into account that all there is no minors with children.


ggplot(data=aa) + aes(x=Parch, fill=Survived) + 
  geom_histogram(bins= 15,colour = "black")+ xlab("Parents") + scale_fill_manual(values=c("white","coral1")) 

#2.2.2.ere we look if the quantity of siblings had an influence on the survival


ggplot(data=aa) + aes(x=SibSp, fill=Survived) +
  geom_histogram(bins= 15,colour = "black")+ xlab("Siblings") +scale_fill_manual(values=c("white","coral1"))

#2.2.3. Finally with make a mix of the two graph to create a graph of the influence of 
#company of children on their survival.

ggplot(data=aa) + aes(x=Parch, y= SibSp, fill=Survived)+ geom_tile(size=6) + xlab("Parents") + ylab("Siblings") +scale_fill_manual(values=c("white","coral1"))


#2.3 Question 3
#We first create a graph divided in two box plot
#of the money in function of the survival.
#we made the two summary that give form to the  box plots
#survivors
summary(titanic.train[which(titanic.train$Survived==1),]$Fare)
#people who passed away
summary(titanic.train[which(titanic.train$Survived==0),]$Fare)

#2.3.1

ggplot(titanic.train) + aes(x=Fare, fill= Survived) + geom_boxplot()

#Now to take a look closer we divide the people in rich and poor, (here the name of the variable don't realy
#show the economic class of people, it is just a reminder for us). If they can travel in titanic they are all rich. 
#2.3.2
rich = data.frame(titanic.train[which(titanic.train$Fare<100.000),])
ggplot(rich) + aes(x=Fare, fill= Survived) + geom_boxplot()

#2.3.3.
poor=data.frame(titanic.train[which(titanic.train$Fare>100.000),])
ggplot(poor) + aes(x=Fare, fill= Survived) + geom_boxplot()

#2.4. Question 4
#2.4.1 Now we look to the people with more age and their fare associated

#Survival by genre and fare for older people.
older_people=data.frame(titanic.train[which(titanic.train$Age>60),])

#Here we take a quick look to the data in order to find it logical.
titanic.train[which(titanic.train$Age>60 & titanic.train$Sex=="female"),]
titanic.train[which(titanic.train$Age>60 & titanic.train$Sex=="male"),]

#And we create the graph 
ggplot(older_people) + aes(x=Fare,fill=Survived) + 
  geom_histogram(bins=20,colour="black", aes(y=..density..))+ 
  facet_grid(Sex~.) + scale_fill_manual(values=c("white","coral1")) 


#2.5. Here we take a look to the people that didn't pay anything.
#it is not a very difficult graph but we find it very interesting.
titanic.train[which(titanic.train$Fare<1),]
ggplot(titanic.train[which(titanic.train$Fare<1),]) + aes(x=Survived) + geom_bar()

#2.6.Question 6
#We take a look to the fare and the port of embarkation to see if there is any relation ship

#6.6.1. 
#We first did a histogram but we thought that it wasn't clear enough and a little bit repetitive so we changed it by the curves.
ggplot(titanic.train) + aes(x=Fare, fill= Embarked) +
  geom_histogram(bins=20,colour="black", aes(y=..density..))+ 
  scale_fill_manual(values=c("lightsalmon4", "lightgreen", "lightcoral"))


#So we did a graph with three curves for the ports of embarkation.
ggplot(titanic.train) + aes(x=Fare, y= Embarked,fill= Embarked) +
  geom_violin(colour="black")+ 
  scale_fill_manual(values=c("lightsalmon4", "lightgreen", "lightcoral"))


#2.6.2. So we do one time again one for the rich people.
#We first did a histogram but we thought that it wasn't clear enough and a little bit repetitive so we changed it by the curves.
ggplot(rich) + aes(x=Fare, fill= Embarked) + 
  geom_histogram(bins=20,colour="black", aes(y=..density..))+ 
  scale_fill_manual(values=c("lightsalmon4", "lightgreen", "lightcoral"))

#That' is the curve we used finally.
ggplot(rich) + aes(x=Fare, y= Embarked,fill= Embarked) + 
  geom_violin(colour="black")+ scale_fill_manual(values=c("lightsalmon4", "lightgreen", "lightcoral"))


#2.6.3. and one for variable poor.
#We first did a histogram but we thought that it wasn't clear enough and a little bit repetitive so we changed it by the curves.
ggplot(poor) + aes(x=Fare, fill= Embarked) + 
  geom_histogram(bins=20,colour="black", aes(y=..density..))+ 
  scale_fill_manual(values=c("lightsalmon4", "lightcoral", "lightgreen"))

#That's the curved we used.
ggplot(poor) + aes(x=Fare, y = Embarked,fill= Embarked) + 
  geom_violin(colour="black") + 
  scale_fill_manual(values=c("lightsalmon4", "lightcoral"))

#2.7.
#We create a data. frame that says that a family is a big family or not.
Big_Families = ((titanic.train$Parch + titanic.train$SibSp)>=3)
#and we do the scatterplott.
ggplot(titanic.train) + aes(x= Fare, y= Age, colour=Big_Families) + geom_point(size=1) + scale_colour_manual(values=c("blue","sienna")) 


 




 #we had no more space to put the rest of the graphs , even if we 
#putted the ones that seemed more interesting for us , we have let here below the ones we could not add.
#It 's not part of the work but we have let them here in case you want to take a look.


#Survival by genre age and fare 

#This histogram represent the survivors in function of they fare and divided by their genre.
ggplot(titanic.train) + aes(x=Fare, fill=Survived) +
  geom_histogram(bins=20,colour="black", aes(y=..density..)) + facet_grid(Sex~.)

#This histogram does the same but only for children(minors)
ggplot(aa) + aes(x=Fare,fill=Survived) +
  geom_histogram(bins=20,colour="black", aes(y=..density..))+ facet_grid(Sex~.)



#This histogram show us the class of the people in function of their fare 
ggplot(titanic.train) + aes(x=Fare, fill= Pclass) + geom_histogram(bins=20,colour="black", aes(y=..density..))+ 
  scale_fill_manual(values=c("lightsalmon4", "lightcoral", "lightgreen"))
#this one is for the variable rich 
ggplot(rich) + aes(x=Fare, fill= Pclass) + geom_histogram(bins=20,colour="black", aes(y=..density..))+ 
  scale_fill_manual(values=c("lightsalmon4", "lightcoral", "lightgreen"))

#and this one for the poor variable.
ggplot(poor) + aes(x=Fare, fill= Pclass) + geom_histogram(bins=20,colour="black", aes(y=..density..))+ 
  scale_fill_manual(values=c("lightsalmon4", "lightcoral", "lightgreen"))

#This graph were only useful o show the logic of the datum because it is
#obvious that the more you pay the more you class is higher

#This bar chart so us the survivors by port of embarkation 
ggplot(titanic.train) + aes(x=Embarked, fill=Survived) + geom_bar
#This bar chart showed us the class of the people who embarked on each port.
ggplot(titanic.train) + aes(x=Embarked, fill=Pclass) + geom_bar()
#This bar chart show us the survivor for each class.
ggplot(titanic.train) + aes(x=Pclass, fill=Survived) + geom_bar()
#All this 3 graphs were not very relevant and interesting


#Here is a little work for creating a variable with the first 
#letter of the cabin but we ere not able to finish it even if we though it was very interesting
cabin2 = data.frame(substr(titanic.train$Cabin,1,1))

titanic.train=data.frame(c(titanic.train,cabin2))
colnames(titanic.train)=c("Survived","Pclass","Sex","Age","SibSp","Parch","Ticket","Fare","Cabin","Embarked","Cabin2")
View(titanic.train)
cab=data.frame(which(titanic.train$Cabin2!=""))

prop_cab=prop.table(table(titanic.train$Cabin2[cab]))

