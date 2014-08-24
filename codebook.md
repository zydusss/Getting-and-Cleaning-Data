---
title: "CodeBook"
author: "Rahul Bajaj"
date: "Sunday, August 24, 2014"
output: html_document
---

### Codebook : About Dataset

This is a tidy version of the dataset: Human Activity Recognition Using Smartphones Dataset (Version 1.0). It contains
accelerometer measurements from Samsung Galaxy S smartphones while subjects performed various activities. For the
particulars of the measurements recorded and their derivation, refer to the documentation of the dataset location in
features_info.txt

### Data Processing
The first is a merge of both the testing and training measurements datasets filtered toinclude only the variables related to mean and standard deviation measurements.

The following variables are loaded from the CI HAR Dataset
X_train
X_test

The observations of these tables are merged with a call to merge() and the results are stored in the tidy_X data frame.

Indicies of the columns pertaining to the mean and standard deviation are determined by running a grep against thefeature dataset selecting on mean() and std() . 

The indicies are saved in the vector relevant.measures and are used to
extract the columns from the X_train and X_test data sets.


The activity variables are labeled by extracting the variable names from the second column of the features data set, scrubbed to remove special characters that make the variables difficult to reference without escaping variable references, and applied to the tidy.measurements data frame assigning the result to the data frame with colnames(). 

Special characters are removed by calling str_replace_all on each measurement name to replace parenthesis and dash characters.

The second dataset presents the average of each of the measurement variables, broken out by activity type.

A map of the activity type for each observation is created by merging the y_ data for testing and training in the same order as the merge for the X_ observations.

The dataset tidy.measurements is split into data frames grouped by the activity factor. 

A mean() is applied to each data frame to compute the average for each measurement of each activity. 

The resulting set of six vectors are merged as rows in a data frame, one row per activity, and the result is stored in the tidy.data.activities dataset. 

The activity variables are then named by applying the labels from the activity_labels dataset to the columns of the tidy.data.activities dataset.

