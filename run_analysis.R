# Script to check the presence of file:
# Download if not available

if(!file.exists("Samsung_DS")) {
  dir.create("Samsung_DS")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Samsung_DS\\Samsung_Acc.zip")
} else {
  if(!file.exists("Samsung_DS\\Samsung_Acc.zip"))
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Samsung_DS\\Samsung_Acc.zip")
}


# Unzip & Extract Files
unzip("Samsung_DS\\Samsung_Acc.zip", files = NULL, list = FALSE, overwrite = TRUE,junkpaths = FALSE, exdir = "Samsung_DS\\Extract", unzip = "internal",setTimes = FALSE)


# Read data from Files

x_test <- read.table("Samsung_DS\\Extract\\UCI HAR Dataset\\test\\X_test.txt")
x_train <- read.table("Samsung_DS\\Extract\\UCI HAR Dataset\\train\\y_train.txt")



# Merges the training and the test sets to create one data set.
x <- merge(x_test,x_train,all=TRUE)
y <- merge(y_test,y_train,all=TRUE)
subject <- merge(subject_test,subject_train,all=TRUE)


# Remove unwanted variables
rm(x_test)
rm(x_train)


features<-read.table("Samsung_DS\\Extract\\UCI HAR Dataset\\features.txt")
activity_labels<-read.table("Samsung_DS\\Extract\\UCI HAR Dataset\\activity_labels.txt")

relevant.measurements <- grep('mean\\(|std\\(', features$V2)
tidy_X <- x[, relevant.measurements]


#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive activity names.


measurement.labels <- features[relevant.measurements, 2];
colnames(tidy_X) <- sapply(measurement.labels, function(x) str_replace_all(x, "\\(\\)|-",""))

write.table(tidy_X, 'tidy_X.txt')


## average data in a table with index ids subject, activity
y_test <- read.table("Samsung_DS\\Extract\\UCI HAR Dataset\\test\\y_test.txt")
y_train <- read.table("Samsung_DS\\Extract\\UCI HAR Dataset\\train\\y_train.txt")

subject_test <- read.table("Samsung_DS\\Extract\\UCI HAR Dataset\\test\\subject_test.txt")
subject_train <- read.table("Samsung_DS\\Extract\\UCI HAR Dataset\\train\\subject_train.txt")


activity <- rbind(y_test, y_train)[[1]]
subject <- rbind(subject_test, subject_train)[[1]]


indexed_dataset <- data.frame(cbind(subject, activity, tidy_X))

tidy.data.grouped <- aggregate(indexed_dataset, by=list(activity, subject), FUN=mean)

write.table(tidy.data.grouped, 'tidy.data.grouped.txt')

## split arrays and store average data in nested objects
indexed.activity.data <- split(indexed_dataset, activity)
indexed.activity.subject.data <- lapply(indexed.activity.data, function(x) { split(x, x$subject) }) 
tidy.data.nested <- lapply(indexed.activity.subject.data , function(x) { lapply(x, function(y) sapply(y, mean) )} )
names(tidy.data.nested) <- activity_labels[,2]
write.table(tidy.data.nested, 'tidy.data.nested.txt')
install.packages("reshape")
library('plyr')
library('reshape')

## melted but not referencable
tidy.data.melted <- lapply(indexed.activity.data, function(x) cast(melt(x, id=c("subject")), variable ~ subject, mean))
names(tidy.data.melted) <- activity_labels[,2]
write.table(tidy.data.melted, 'tidy.data.melted.txt')

## Average by activity (though not by subject)

tidy.2.tmp <- split(tidy.measurements, activity)
tidy.2.tmp.1 <- sapply(tidy.2.tmp$`1`, mean)
tidy.2.tmp.2 <- sapply(tidy.2.tmp$`2`, mean)
tidy.2.tmp.3 <- sapply(tidy.2.tmp$`3`, mean)
tidy.2.tmp.4 <- sapply(tidy.2.tmp$`4`, mean)
tidy.2.tmp.5 <- sapply(tidy.2.tmp$`5`, mean)
tidy.2.tmp.6 <- sapply(tidy.2.tmp$`6`, mean)

tidy.data.activities <- data.frame(activity1=tidy.2.tmp.1
                                   , activity2=tidy.2.tmp.2
                                   , activity3=tidy.2.tmp.3
                                   , activity4=tidy.2.tmp.4
                                   , activity5=tidy.2.tmp.5
                                   , activity6=tidy.2.tmp.6)
colnames(tidy.data.activities) <- activity_labels[,2]

write.table(tidy.data.activities, 'tidy.data.activities.txt')
