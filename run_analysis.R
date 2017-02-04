library(dplyr)

#download the file
filename <- "assignment.zip"


if(!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,filename)
}

if (!file.exists("UCI HAR Dataset")){ 
  unzip(filename) 
}

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("code","name"),colClasses = c("factor","character"))
features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE,col.names = c("code","name"))
features <- features[grepl(".*mean.*|.*std.*",features$name),]
featuresSelected <- features$code
featuresNames <- features$name
#clean Data Frame names
featuresNames <- gsub("[-|/(/)]","",featuresNames)
featuresNames <- gsub("mean","Mean",featuresNames)
featuresNames <- gsub("std","Std",featuresNames)

test.data <- read.table("./UCI HAR Dataset/test/X_test.txt")[,featuresSelected]
test.activities <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = "code",colClasses = "factor")
test.activities <- merge(test.activities,activityLabels)
test.subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "code",colClasses = "factor")
test.df <- cbind(test.subjects$code,test.activities$name,test.data)
names(test.df) <- c("subject","activity",featuresNames)

train.data <- read.table("./UCI HAR Dataset/train/X_train.txt")[,featuresSelected]
train.activities <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "code",colClasses = "factor")
train.activities <- merge(train.activities,activityLabels)
train.subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "code",colClasses = "factor")
train.df <- cbind(train.subjects$code,train.activities$name,train.data)
names(train.df) <- c("subject","activity",featuresNames)

total <- rbind(train.df,test.df)