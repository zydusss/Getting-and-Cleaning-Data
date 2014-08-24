---
title: "Readme.MD"
author: "Rahul Bajaj"
date: "Sunday, August 24, 2014"
output: html_document
---

## Getting & Cleaning Data - Project


###Dataset 

Source dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The dataset contains 3-axial linear acceleration and 3-axial angular velocity captured at a constant rate of 50Hz wearing a smartphone (Samsung Galaxy S II) on the waist.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


### Notes

* Only vaiables containing mean() & std() are used.
* Requires the plyr & reshape2 packages.
* The script run_analysis.R does the following 
    + Check if the dataset is already present in the current directory
    + If not present, downloads the dataset and unzips
    + Merges the training and the test sets to create one data set.
    + Extracts only the measurements on the mean and standard deviation for each measurement.
    + Uses descriptive activity names to name the activities in the data set
    + Appropriately labels the data set with descriptive activity names.
    + Creates a second, independent tidy data set with the average of each       variable for each activity and each subject


### Script Execution

$Rscript run_analysis.R

