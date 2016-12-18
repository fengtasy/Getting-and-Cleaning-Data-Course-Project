# Getting and Cleaning Data - Course Project

The project is for the Coursera Data Science Specialization course - Getting and Cleaning Data.
The purpose of this project is to demonstrate student's ability to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis.

Here are the data sets for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R script `run_analysis.R` processes the data as below:

1. Download and unzip data set into the working directory
2. Load and review the test data sets and the train data sets
3. Load and review the features and activity labels data sets
4. Appropriately labels the data set with descriptive variable names
5. Merge all test data sets into one data frame
6. Merge all train data sets into one data frame
7. Merge rows of the merged test data sets and train data sets
8. Get desired column names - match only those columns which reflect a mean or standard deviation, plus activityID and subjectID columns
9. Extract the measurements on the mean and standard deviation
10. Apply descriptive activity labels to name the activities in the data set
11. From the data set `WithActivityNames`, create a tidy data set, which consists of the mean value of each variable for each subject and activity pair
12. Export the tidy data set `TidyDataSet.txt` to the data directory
