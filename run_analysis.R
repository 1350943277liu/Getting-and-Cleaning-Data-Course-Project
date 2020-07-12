library(dplyr)
library(tidyr)

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

subject_test <- mutate(subject_test, usage ="test")
subject_train <- mutate(subject_train, usage ="test")


test <- cbind(subject_test, Y_test, X_test)
train <- cbind(subject_train, Y_train, X_train)

activities <- rbind(test, train)
names(activities) <- c("subject", "usage", "activity", features)