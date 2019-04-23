### GETTING AND CLEANING DATA COURSE PROJECT
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. 

#You will be required to submit: 
    #1) a tidy data set as described below, 
    #2) a link to a Github repository with your script for performing the analysis, and 
    #3) a code book that describes the variables, the data, and any transformations or work that you performed 
        #to clean up the data called CodeBook.md. 

#You should create one R script called run_analysis.R that does the following.
    #Merges the training and the test sets to create one data set.
    #Extracts only the measurements on the mean and standard deviation for each measurement.
    #Uses descriptive activity names to name the activities in the data set
    #Appropriately labels the data set with descriptive variable names.
    #From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#Download the data and unzip
fileName <- "UCIdata.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

if(!file.exists(fileName)){
    download.file(url,fileName, mode = "wb")
}

#Unzip
if(!file.exists(dir)){
    unzip("UCIdata.zip", files = NULL, exdir=".")
}

#Read data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#Merges Training and Test Sets
merged_data <- rbind(X_train, X_test)

#Extracts Mean and Standard Deviation for each measurement
Mean_and_Std <- grep("mean()|std()", features[,2])
merged_data <- merged_data[,Mean_and_Std]

#Add Labels
CleanFeatureNames <- sapply(features[,2],function(x){gsub("[()]","",x)})
names(merged_data) <- CleanFeatureNames[Mean_and_Std]
head(merged_data)

#combine test and train and give labels
subject <- rbind(subject_train,subject_test)
names(subject) <- 'subject'
activity <- rbind(Y_train,Y_test)
names(activity) <- 'activity'

#combine subject, activity, and mean/std to create final dataset
dataSet <- cbind(subject,activity, merged_data)

#Uses descriptive activity names to name activities in the dataset
#group the activity column of dataSet, rename label of levels, and apply it
activity_group <- factor(dataSet$activity)
levels(activity_group) <- activity_labels[,2]
dataSet$activity <- activity_group

##Creates second, independent tidy dataset with the avg. of each variable for each activity/subject
library("reshape2")

base <- melt(dataSet, (id.vars= c("subject","activity")))
secondDataSet <- dcast(base, subject + activity ~ variable, mean)
names(secondDataSet)[-c(1:2)] <- paste("[mean of]", names(secondDataSet)[-c(1:2)])
head(secondDataSet)

write.table(secondDataSet, "tidy_data.txt", sep = ",")