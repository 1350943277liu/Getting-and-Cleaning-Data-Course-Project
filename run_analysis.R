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
label_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
set_test <- read.table("./UCI HAR Dataset/test/X_test.txt")


subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
label_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
set_train <- read.table("./UCI HAR Dataset/train/X_train.txt")



## Merge the train and the test sets to create one data set
subject_test <- mutate(subject_test, usage ="test")
subject_train <- mutate(subject_train, usage ="train")

test <- bind_cols(subject_test, label_test, set_test)
train <- bind_cols(subject_train, label_train, set_train)

activities <- bind_rows(test, train)
names(activities) <- c("subject", "usage", "activity", features)

activities <- as_tibble(activities, .name_repair = "minimal")


## Extract only the measurements on the mean and standard deviation for each measurement
activities <- activities %>%
        select(1:3, contains("mean()") | contains("std()")) %>%
        arrange(subject, activity)

activities <- bind_cols(specifier = 1:nrow(activities), activities) %>%
        pivot_longer(cols = 5:70, names_to = "measurement", values_to = "value") 


## Convert "usage" and "activity" into factors
activities$activity <- activity_labels[activities$activity]
activities$activity <- factor(activities$activity, levels = activity_labels)

activities$usage <- factor(activities$usage)


## further treatment of separating statistical index "mean" and "std" out of measurement
data.mean <- activities[grep("mean", activities$measurement),] %>%
        mutate(method="mean")       

data.std <- activities[grep("std", activities$measurement),] %>%
        mutate(method="std") 

activities <- bind_rows(data.mean, data.std)

activities$measurement <- sub("-(mean|std)[(][)]", "", activities$measurement)
activities$activity <- sub("_", " ", activities$activity)

activities <- pivot_wider(activities, names_from = method) %>%
        arrange(subject, activity, measurement)

activities$measurement <- factor(activities$measurement)

## output result
write.csv(activities, "Tidy_data.csv")
