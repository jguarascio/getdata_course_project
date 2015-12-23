# README file for:  
https://github.com/jguarascio/getdata_course_project

## Abstract
This repository was created for the submission of the Getting and Cleaning Data course project.  The purpose of this project is to prepare an aggregate data set from the Human Activity Recognition Using Smartphones Data Set (HAR).  The dataset contains 561 measures from 30 different participants while doing various activities.  There are two main partitions of the data, one used during training and one for testing. The resultant aggregate data set will contain the means of all "mean" and "std" measures from both the test and training data by subject and activity.  The output (har_means.txt) is a "long form" dataset with each measure/variable represented as a row.  


## Repo contents
* README.md - This file
* run_analysis.R - Script for taking raw data from the study and generating a dataset of means by measure by subject and activity
* CodeBook.md - a description of the fields in the dataset

## Data Processing
The code to process the dataset is found in run_analysis.R

The following steps are performed.

1. Load all data sources into R
2. Combine the test and train datasets
3. Use featurs list to label the columns of the dataset
4. Use activities list to label the activities for each row in the dataset
5. Select the specific mean/std columns out of the feature list
6. Pivot the measures into rows (melt)
7. Aggregate the the intermediate pivot by subject, activity, and measure


## Using the dataset
The following R command can be used to read the har_means.txt dataset into R.

harmeans <- read.table("har_means.txt", header = TRUE)

or

library(data.table)
harmeans <- fread("har_means.txt")
