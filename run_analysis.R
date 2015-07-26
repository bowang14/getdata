##Part One    Data reading

  ##read data of activities and measurements
features=read.table(".\\UCI HAR Dataset\\features.txt")
activity_labels=read.table(".\\UCI HAR Dataset\\activity_labels.txt")

  ##read data from group train
X_train=read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
y_train=read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
subject_train=read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")

  ##read data from group test
X_test=read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
y_test=read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
subject_test=read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")


##Part Two    Merging and Renaming

  ##combine items in group trian and group test respectively
train=cbind.data.frame(y_train,subject_train,X_train)
test=cbind.data.frame(y_test,subject_test,X_test)

  ##combine them together
mydata=rbind.data.frame(train,test)

  ##rename the colnames(measurements)
names(mydata)=c("activity","subject",as.character(features$V2))

  ##rename the activity names(columen 1 of mydata)
mydata$activity=as.factor(mydata$activity)
levels(mydata$activity)=activity_labels$V2


##Part Three    Restrain Columns into Mean and Standard Deviation Only
t1=grep("mean",names(mydata))
t2=grep("std",names(mydata))
  ##Column 1 is activity. Column 2 is subject. Column t1,t2 are mean and std.
mydata=mydata[,c(1,2,t1,t2)]


##Part Four    Make the Second Dataset

  ##change mydata into a narrow set
narrowdata=melt(mydata,id=c(names(mydata)[1:2]),measure.vars=c(names(mydata)[3:81]))

  ##make a factor based on activity and subject
levels(narrowdata$activity)=1:6
narrowdata$activity=as.numeric(as.character(narrowdata$activity))
subject=narrowdata$activity*100+narrowdata$subject
narrowdata=cbind(subject,narrowdata)

  ##calculate average for each subect and each activity
newdata=dcast(narrowdata,subject~variable,mean)

  ##get activity and subject back
activity=floor(newdata$subject/100)
newdata$subject=newdata$subject-activity*100
activity=as.factor(activity)
levels(activity)=activity_labels$V2
newdata=cbind.data.frame(activity,newdata)

  ##write a txt file
write.table(newdata,file="newdata.txt",row.names=FALSE)
