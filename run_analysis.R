library(dplyr)
library(reshape2)

##download the fzip ile
filename <- "assignment.zip"

if(!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,filename)
}

##decompress the zip file
if (!file.exists("UCI HAR Dataset")){ 
  unzip(filename) 
}

##read dataframes
#read the Activity name dataframe
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE,col.names = c("code","name"))
#read the features name dataframe
features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE,col.names = c("code","name"))
#select only the interested columns
features <- features[grepl(".*mean.*|.*std.*",features$name),]
featuresIndex <- features$code
featuresNames <- features$name
#clean Data Frame names
featuresNames <- gsub("[-|/(/)]","",featuresNames)
featuresNames <- gsub("mean","Mean",featuresNames)
featuresNames <- gsub("std","Std",featuresNames)

#read the feature values for the test dataframe
test.data <- read.table("./UCI HAR Dataset/test/X_test.txt")[,featuresIndex]
#read the activities for the test dataframe
test.activities <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = "code")
test.activities <- factor(test.activities$code, levels = activityLabels$code, labels = activityLabels$name)
#read the subjects for the test dataframe
test.subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "code")
#create the test dataframe
test.df <- cbind(test.subjects$code,test.activities,test.data)
names(test.df) <- c("subject","activity",featuresNames)

#read the feature values of the train dataframe
train.data <- read.table("./UCI HAR Dataset/train/X_train.txt")[,featuresIndex]
#read the activities for the train dataframe
train.activities <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "code")
train.activities <- factor(train.activities$code, levels = activityLabels$code, labels = activityLabels$name)
#read the subjects for the train dataframe
train.subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "code")
#create the train dataframe
train.df <- cbind(train.subjects$code,train.activities,train.data)
names(train.df) <- c("subject","activity",featuresNames)

##create the total dataframe by binding the test and train dataset
total <- rbind(test.df,train.df)

##Create of the dataframe that contain the average of each variable for each activity and each subject.
totalMelted <- melt(total, id = c("subject", "activity"))
totalMean <- dcast(totalMelted, subject + activity ~ variable, mean)

##write the totalMean dataframe into a txt file
write.table(totalMean, "tidy.txt", row.names = FALSE, quote = FALSE)