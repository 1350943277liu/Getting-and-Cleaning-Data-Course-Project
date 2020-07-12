library(dplyr)
library(tidyr)

## Download and unzip the dataset if necessary
if (!dir.exists("UCI HAR Dataset")) {
        if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
                url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(url, "./getdata-projectfiles-UCI HAR Dataset.zip", method = "curl")
        }
        unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

# Load the train and the test sets
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
activity_labels <- tolower(activity_labels)
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

## Merge the train and the test sets to create one data set
subject_test <- mutate(subject_test, usage ="test")
subject_train <- mutate(subject_train, usage ="test")

test <- bind_cols(subject_test, Y_test, X_test)
train <- bind_cols(subject_train, Y_train, X_train)

activities <- bind_rows(test, train)
names(activities) <- c("subject", "usage", "activity", features)

activities <- as_tibble(activities, .name_repair = "minimal")

## Extract only the measurements on the mean and standard deviation for each measurement
activities <- activities %>%
        select(1:3, contains("mean"), contains("std")) %>%
        pivot_longer(cols = 4:89, names_to = "measurement", values_to = "value")

# Convert "usage" and "activity" as factor
activities$activity <- activity_labels[activities$activity]
activities$activity <- factor(activities$activity, levels = activity_labels)

activities$usage <- factor(activities$usage)
