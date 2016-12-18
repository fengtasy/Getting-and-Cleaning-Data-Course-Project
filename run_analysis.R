
# Merges the training and the test sets to create one data set. ####

## 1.1) Download and Unzip Data Set ####
setwd("./Week4")
getwd()
if(!file.exists("./data")){
        dir.create("./data")
}

zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zip_url, "./data/accelerometer_data.zip")
unzip("./data/accelerometer_data.zip", exdir = "accelerometer_data")

## 1.2) Load and Review Test Data Sets ####
X_test <- read.table("./accelerometer_data/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./accelerometer_data/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./accelerometer_data/UCI HAR Dataset/test/subject_test.txt")

## 1.3) Load and Review Train Data Sets ####
X_train <- read.table("./accelerometer_data/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./accelerometer_data/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./accelerometer_data/UCI HAR Dataset/train/subject_train.txt")

## 1.4) Load and Review Features Data Set ####
features <- read.table("./accelerometer_data/UCI HAR Dataset/features.txt")

## 1.5) Load and Review Activity Labels Data Set ####
activityLabels = read.table("./accelerometer_data/UCI HAR Dataset/activity_labels.txt")

# Appropriately labels the data set with descriptive variable names ####
colnames(X_test) <- features[,2]
colnames(X_train) <- features[,2]

names(X_test);names(X_train)

colnames(Y_test) <- "activityID"
colnames(Y_train) <- "activityID"

names(Y_test);names(Y_train)

colnames(subject_test) <- "subjectID"
colnames(subject_train) <- "subjectID"

colnames(activityLabels) <- c("activityID","activityLabel")

## 1.6) Merge tables ####

### 1.6.1) Merge all test data sets by columns ####
mergeTest <- cbind(Y_test,subject_test,X_test)

### 1.6.2) Merge all train data sets by columns ####
mergeTrain <- cbind(Y_train,subject_train,X_train)

### 1.6.3) Merge rows of merged test data sets and train data sets ####
TestTrainInOne <- rbind(mergeTest,mergeTrain)

# Extracts only the measurements on the mean and standard deviation for each measurement. ####

## 2.1) Get column names and Match only required column names by Logic Statement ####
columnName <- colnames(TestTrainInOne)

MatchMeanStd <- (grepl("activityID", columnName)                         |
                 grepl("subjectID", columnName)                          |
                 grepl("-(mean)\\(\\)", columnName, ignore.case = FALSE) |
                 grepl("-(std)\\(\\)", columnName, ignore.case = FALSE)
                )

## 2.2) Extract the measurements on the mean and standard deviation ####
MeanStdSubset <- TestTrainInOne[, MatchMeanStd == TRUE]

# Uses descriptive activity names to name the activities in the data set ####
WithActivityNames <- merge(MeanStdSubset, activityLabels, 
                           by.x = "activityID", by.y = "activityID")

# From the data set in last step, creates a second, independent tidy data set with the average of each variable for each activity and each subject ####
TidyDataSet <- aggregate(formula = . ~subjectID + activityLabel, 
                         data = WithActivityNames, 
                         FUN = mean)

TidyDataSetSorted <- TidyDataSet[order(TidyDataSet$subjectID,TidyDataSet$activityID),]
TidyDataSetFinal <- subset(TidyDataSetSorted, select = -activityID)

## 3.1）Export the tidy data set to the data directory ####
write.table(TidyDataSetFinal, "./data/TidyDataSet.txt", row.name=FALSE, quote = TRUE)



