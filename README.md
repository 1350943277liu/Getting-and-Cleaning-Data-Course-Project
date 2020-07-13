Getting-and-Cleaning-Data-Course-Project
================

## Introduction

This is the peer-graded course project of ["Getting and Cleaning Data"](https://www.coursera.org/learn/data-cleaning?specialization=data-science-foundations-r) on [Coursera](https://www.coursera.org/)

## Included Packages


``` r
library(dplyr)
library(tidyr)
```

## Included Dataset

[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Files Available
`Getting and Cleaning Data Course Project.Rproj`: r project file
`run_analysis.r`: code used to get and clean data  
`CodeBook`: description on variables, data and explanation of transformation performed to clean up the data  
`Tidy_data.csv`: tidy data output of `run_analysis.r`  
`UCI HAR Dataset/`: the raw dataset  
`README.md`: brief introduction

## Analysis Result
Let's have a look at the tidy data first:
``` r
> activities
# A tibble: 339,867 x 7
   specifier subject usage activity measurement   mean    std
       <int>   <int> <fct> <fct>    <fct>        <dbl>  <dbl>
 1         1       1 train walking  fBodyAcc-X  -0.261 -0.357
 2         2       1 train walking  fBodyAcc-X  -0.151 -0.262
 3         3       1 train walking  fBodyAcc-X  -0.230 -0.294
 4         4       1 train walking  fBodyAcc-X  -0.151 -0.263
 5         5       1 train walking  fBodyAcc-X  -0.226 -0.227
 6         6       1 train walking  fBodyAcc-X  -0.290 -0.200
 7         7       1 train walking  fBodyAcc-X  -0.164 -0.263
 8         8       1 train walking  fBodyAcc-X  -0.188 -0.272
 9         9       1 train walking  fBodyAcc-X  -0.275 -0.387
10        10       1 train walking  fBodyAcc-X  -0.236 -0.274
# … with 339,857 more rows
```
It satisfies [Hadley Wickham's principles on tidy data](http://vita.had.co.nz/papers/tidy-data.pdf) below, so it is tidy.

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

For detailed information, please check `CodeBook.md` and `run_analysis.r`.
