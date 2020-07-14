README
================

## Introduction

This is the peer-graded course project of [“Getting and Cleaning
Data”](https://www.coursera.org/learn/data-cleaning?specialization=data-science-foundations-r)
on [Coursera](https://www.coursera.org/)

## Included Dataset

[Human Activity Recognition Using Smartphones Data
Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion components,
was separated using a Butterworth low-pass filter into body acceleration
and gravity. The gravitational force is assumed to have only low
frequency components, therefore a filter with 0.3 Hz cutoff frequency
was used. From each window, a vector of features was obtained by
calculating variables from the time and frequency domain.

## Files Available

`Getting and Cleaning Data Course Project.Rproj`: r project file
`run_analysis.r`: code used to get and clean data  
`CodeBook`: description on variables, data and explanation of
transformation performed to clean up the data  
`Tidy_data.csv`: tidy data output of `run_analysis.r`  
`UCI HAR Dataset/`: the raw dataset  
`README.md`

## Analysis Procedure

Let’s review [Hadley Wickham’s principles on tidy
data](http://vita.had.co.nz/papers/tidy-data.pdf) first.

1.  Each variable forms a column.
2.  Each observation forms a row.
3.  Each type of observational unit forms a table.

And [Hadley Wickham’s standard on messy
data](http://vita.had.co.nz/papers/tidy-data.pdf)

  - Column headers are values, not variable names.  
  - Multiple variables are stored in one column.  
  - Variables are stored in both rows and columns.  
  - Multiple types of observational units are stored in the same table.
  - A single observational unit is stored in multiple tables.

### Load Needed Packages and Files

``` r
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
```

### Merge Dataset

Combine variables containing subject, activity and measurement data into
`activities`

``` r
## Merge the train and the test sets to create one data set
subject_test <- mutate(subject_test, usage ="test")
subject_train <- mutate(subject_train, usage ="train")

test <- bind_cols(subject_test, label_test, set_test)
```

    ## New names:
    ## * V1 -> V1...1
    ## * V1 -> V1...3
    ## * V1 -> V1...4

``` r
train <- bind_cols(subject_train, label_train, set_train)
```

    ## New names:
    ## * V1 -> V1...1
    ## * V1 -> V1...3
    ## * V1 -> V1...4

``` r
activities <- bind_rows(test, train)
names(activities) <- c("subject", "usage", "activity", features)

activities <- as_tibble(activities, .name_repair = "minimal")
```

### Extract Only The Mean and Std Subset

Use `select()` for mean/std data screening

``` r
activities <- activities %>%
        select(1:3, contains("mean()") | contains("std()")) %>%
        arrange(subject, activity)
```

There are variables:subject, usage, activity label, mean and standard
deviation.

According to Hadley Wickham’ principle for tidy and messy data, it is
not difficult to find that some values(features) are part of column
headers as well as multiple variables(measurement, mean and std) are
stored in the same column as shown below.

``` r
activities
```

    ## # A tibble: 10,299 x 69
    ##    subject usage activity `tBodyAcc-mean(… `tBodyAcc-mean(… `tBodyAcc-mean(…
    ##      <int> <chr>    <int>            <dbl>            <dbl>            <dbl>
    ##  1       1 train        1            0.282         -0.0377           -0.135 
    ##  2       1 train        1            0.256         -0.0646           -0.0952
    ##  3       1 train        1            0.255          0.00381          -0.124 
    ##  4       1 train        1            0.343         -0.0144           -0.167 
    ##  5       1 train        1            0.276         -0.0296           -0.143 
    ##  6       1 train        1            0.255          0.0212           -0.0489
    ##  7       1 train        1            0.321          0.00158          -0.0436
    ##  8       1 train        1            0.235         -0.0495           -0.112 
    ##  9       1 train        1            0.313         -0.0264           -0.131 
    ## 10       1 train        1            0.277         -0.0355           -0.0806
    ## # … with 10,289 more rows, and 63 more variables: `tGravityAcc-mean()-X` <dbl>,
    ## #   `tGravityAcc-mean()-Y` <dbl>, `tGravityAcc-mean()-Z` <dbl>,
    ## #   `tBodyAccJerk-mean()-X` <dbl>, `tBodyAccJerk-mean()-Y` <dbl>,
    ## #   `tBodyAccJerk-mean()-Z` <dbl>, `tBodyGyro-mean()-X` <dbl>,
    ## #   `tBodyGyro-mean()-Y` <dbl>, `tBodyGyro-mean()-Z` <dbl>,
    ## #   `tBodyGyroJerk-mean()-X` <dbl>, `tBodyGyroJerk-mean()-Y` <dbl>,
    ## #   `tBodyGyroJerk-mean()-Z` <dbl>, `tBodyAccMag-mean()` <dbl>,
    ## #   `tGravityAccMag-mean()` <dbl>, `tBodyAccJerkMag-mean()` <dbl>,
    ## #   `tBodyGyroMag-mean()` <dbl>, `tBodyGyroJerkMag-mean()` <dbl>,
    ## #   `fBodyAcc-mean()-X` <dbl>, `fBodyAcc-mean()-Y` <dbl>,
    ## #   `fBodyAcc-mean()-Z` <dbl>, `fBodyAccJerk-mean()-X` <dbl>,
    ## #   `fBodyAccJerk-mean()-Y` <dbl>, `fBodyAccJerk-mean()-Z` <dbl>,
    ## #   `fBodyGyro-mean()-X` <dbl>, `fBodyGyro-mean()-Y` <dbl>,
    ## #   `fBodyGyro-mean()-Z` <dbl>, `fBodyAccMag-mean()` <dbl>,
    ## #   `fBodyBodyAccJerkMag-mean()` <dbl>, `fBodyBodyGyroMag-mean()` <dbl>,
    ## #   `fBodyBodyGyroJerkMag-mean()` <dbl>, `tBodyAcc-std()-X` <dbl>,
    ## #   `tBodyAcc-std()-Y` <dbl>, `tBodyAcc-std()-Z` <dbl>,
    ## #   `tGravityAcc-std()-X` <dbl>, `tGravityAcc-std()-Y` <dbl>,
    ## #   `tGravityAcc-std()-Z` <dbl>, `tBodyAccJerk-std()-X` <dbl>,
    ## #   `tBodyAccJerk-std()-Y` <dbl>, `tBodyAccJerk-std()-Z` <dbl>,
    ## #   `tBodyGyro-std()-X` <dbl>, `tBodyGyro-std()-Y` <dbl>,
    ## #   `tBodyGyro-std()-Z` <dbl>, `tBodyGyroJerk-std()-X` <dbl>,
    ## #   `tBodyGyroJerk-std()-Y` <dbl>, `tBodyGyroJerk-std()-Z` <dbl>,
    ## #   `tBodyAccMag-std()` <dbl>, `tGravityAccMag-std()` <dbl>,
    ## #   `tBodyAccJerkMag-std()` <dbl>, `tBodyGyroMag-std()` <dbl>,
    ## #   `tBodyGyroJerkMag-std()` <dbl>, `fBodyAcc-std()-X` <dbl>,
    ## #   `fBodyAcc-std()-Y` <dbl>, `fBodyAcc-std()-Z` <dbl>,
    ## #   `fBodyAccJerk-std()-X` <dbl>, `fBodyAccJerk-std()-Y` <dbl>,
    ## #   `fBodyAccJerk-std()-Z` <dbl>, `fBodyGyro-std()-X` <dbl>,
    ## #   `fBodyGyro-std()-Y` <dbl>, `fBodyGyro-std()-Z` <dbl>,
    ## #   `fBodyAccMag-std()` <dbl>, `fBodyBodyAccJerkMag-std()` <dbl>,
    ## #   `fBodyBodyGyroMag-std()` <dbl>, `fBodyBodyGyroJerkMag-std()` <dbl>

### Add Specifier to Pivot

For each subject, the same activity is measured more than once, which
makes subject id is not a unique observation specifier(or the
`pivot_longer()` and `pivot_wider()` cannot match each observation’s
subject, mean and std correctly) for further cleaning, I add a specifier
column manually.

In addtion, `pivot_longer()` and `pivot_wider()` are more developed
version of outdated `gather()` and `spread()`.

``` r
activities <- bind_cols(specifier = 1:nrow(activities), activities) %>%
        pivot_longer(cols = 5:70, names_to = "measurement", values_to = "value") 
```

### Replace `activities$activity` from Numbers to Characters

``` r
activities$activity <- activity_labels[activities$activity]
activities$activity <- factor(activities$activity, levels = activity_labels)

activities$usage <- factor(activities$usage)
```

### Further Manipulation

Add a column to store what statistical method is used in `measurement`
column, which will be the “names\_from” parameters in next part’s
`pivot_wider()` function.

``` r
data.mean <- activities[grep("mean", activities$measurement),] %>%
        mutate(method="mean")       

data.std <- activities[grep("std", activities$measurement),] %>%
        mutate(method="std") 

activities <- bind_rows(data.mean, data.std)
```

### Pivot Wider

Simplify the format of `measurement` in order to make `pivot_wider` work
better. Reshape the structure, make mean/std become separated columns
filled with corresponding value.

``` r
activities$measurement <- sub("-(mean|std)[(][)]", "", activities$measurement)

activities <- pivot_wider(activities, names_from = method) %>%
        arrange(subject, activity, measurement)

activities$measurement <- factor(activities$measurement)
```

### Output Result

``` r
write.csv(activities, "Tidy_data.csv")
```

## Result Analysis

it satisfies Hadley’s principles, thus it’s tidy.

``` r
activities
```

    ## # A tibble: 339,867 x 7
    ##    specifier subject usage activity measurement   mean    std
    ##        <int>   <int> <fct> <fct>    <fct>        <dbl>  <dbl>
    ##  1         1       1 train walking  fBodyAcc-X  -0.261 -0.357
    ##  2         2       1 train walking  fBodyAcc-X  -0.151 -0.262
    ##  3         3       1 train walking  fBodyAcc-X  -0.230 -0.294
    ##  4         4       1 train walking  fBodyAcc-X  -0.151 -0.263
    ##  5         5       1 train walking  fBodyAcc-X  -0.226 -0.227
    ##  6         6       1 train walking  fBodyAcc-X  -0.290 -0.200
    ##  7         7       1 train walking  fBodyAcc-X  -0.164 -0.263
    ##  8         8       1 train walking  fBodyAcc-X  -0.188 -0.272
    ##  9         9       1 train walking  fBodyAcc-X  -0.275 -0.387
    ## 10        10       1 train walking  fBodyAcc-X  -0.236 -0.274
    ## # … with 339,857 more rows
