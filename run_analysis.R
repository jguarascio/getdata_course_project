# Get the data from the web
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="data.zip")

# Unzip the file
unzip("data.zip")

library(data.table)

# Get feature names
features<-fread("./UCI HAR Dataset/features.txt")

# Get activity labels
activityLabels<-fread("./UCI HAR Dataset/activity_labels.txt")

# Get the training data
path<-"./UCI HAR Dataset/train/"
trainSubject<-fread(paste0(path,"subject_train.txt"))
trainData<-fread(paste0(path,"x_train.txt"))
trainActivity<-fread(paste0(path,"y_train.txt"))

# Add subject and activityid into the main dataset
trainData[,subject:=trainSubject]
trainData[,activityid:=trainActivity]

# Get the test data
path<-"./UCI HAR Dataset/test/"
testSubject<-fread(paste0(path,"subject_test.txt"))
testData<-fread(paste0(path,"x_test.txt"))
testActivity<-fread(paste0(path,"y_test.txt"))

# Add subject and activityid into the main dataset
testData[,subject:=testSubject]
testData[,activityid:=testActivity]

# Merge the train and test sets together
fullData<-rbind(testData,trainData)

# Label the 561 feature columns according to the feature list
setnames(fullData,old=1:561,new=features[[2]])

# Add a column with the actual activity by using the activityid as an index for the
# vector of activity labels
fullData[,activity:=activityLabels[[2]][activityid]]

# Create a vector with the index values of the mean and standard deviation measures 
measureCols<-features[V2 %like% "mean" | V2 %like% "std"][[1]]

# Reshape the data so that our selected measures 
# become rows (i.e., variables) in the final dataset
library(reshape2)
df<-melt(fullData,id=c("subject","activity"),measure.vars=measureCols)

# Create a new dataset representing the mean by subject, activity, and variable
library(plyr)
final<-ddply(df,.(subject,activity,variable),summarize,mean=mean(value))

# Write the dataset out to the disk, no row names per assignment requirements
write.table(final,"har_means.txt",row.names = FALSE)


