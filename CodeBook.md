CodeBook
================

## Overview

Both of train and test data are stored in a data frame called
**activities**.

``` r
summary(activities) #tidy version
```

    ##    specifier        subject        usage                      activity    
    ##  Min.   :    1   Min.   : 1.00   test : 97251   walking           :56826  
    ##  1st Qu.: 2575   1st Qu.: 9.00   train:242616   walking_upstairs  :50952  
    ##  Median : 5150   Median :17.00                  walking_downstairs:46398  
    ##  Mean   : 5150   Mean   :16.15                  sitting           :58641  
    ##  3rd Qu.: 7725   3rd Qu.:24.00                  standing          :62898  
    ##  Max.   :10299   Max.   :30.00                  laying            :64152  
    ##                                                                           
    ##          measurement          mean                std         
    ##  fBodyAcc-X    : 10299   Min.   :-1.000000   Min.   :-1.0000  
    ##  fBodyAcc-Y    : 10299   1st Qu.:-0.946387   1st Qu.:-0.9878  
    ##  fBodyAcc-Z    : 10299   Median :-0.196629   Median :-0.9371  
    ##  fBodyAccJerk-X: 10299   Mean   :-0.330004   Mean   :-0.6927  
    ##  fBodyAccJerk-Y: 10299   3rd Qu.:-0.007234   3rd Qu.:-0.4120  
    ##  fBodyAccJerk-Z: 10299   Max.   : 1.000000   Max.   : 1.0000  
    ##  (Other)       :278073

## The Data

<table>

<tr>

<th>

File Name

</th>

<th>

Description

</th>

</tr>

<tr>

<td valign="top">

`./UCI HAR Dataset/activity_labels.txt`

</td>

<td>

acitivity labels

</td>

</tr>

<tr>

<td valign="top">

`./UCI HAR Dataset/features.txt`

</td>

<td>

sensor signal label

</td>

</tr>

<tr>

<td valign="top">

`./UCI HAR Dataset/test/subject_test.txt`

</td>

<td>

subject included in test group

</td>

</tr>

<tr>

<td valign="top">

`./UCI HAR Dataset/test/X_test.txt`

</td>

<td>

sensor data of test group

</td>

</tr>

<tr>

<td valign="top">

`./UCI HAR Dataset/test/y_test.txt`

</td>

<td>

activity label for each observation

</td>

</tr>

<tr>

<td valign="top">

`./UCI HAR Dataset/train/subject_train.txt`

</td>

<td>

subject included in train group

</td>

</tr>

<tr>

<td valign="top">

`./UCI HAR Dataset/train/X_train.txt`

</td>

<td>

sensor data of train group

</td>

</tr>

<tr>

<td valign="top">

`./UCI HAR Dataset/train/y_train.txt`

</td>

<td>

activity label for each observation

</td>

</tr>

</table>

## The Variables

<table>

<tr>

<th>

Varible Name

</th>

<th>

Description

</th>

</tr>

<tr>

<td valign="top">

activities

</td>

<td>

Vavriable storing the whole data

</td>

</tr>

<tr>

<td valign="top">

activity\_labels

</td>

<td>

Variable storing activity labels in `./UCI HAR
Dataset/activity_labels.txt`

</td>

</tr>

<tr>

<td valign="top">

data.mean

</td>

<td>

intervening variable storing mean values of all observations

</td>

</tr>

<tr>

<td valign="top">

data.std

</td>

<td>

intervening variable storing standard deviation values of all
observations

</td>

</tr>

<tr>

<td valign="top">

features

</td>

<td>

variable storing data of `./UCI HAR Dataset/features.txt`

</td>

</tr>

<tr>

<td valign="top">

label\_test

</td>

<td>

variable storing activity labels of test subject in `./UCI HAR
Dataset/test/y_test.txt`

</td>

</tr>

<tr>

<td valign="top">

label\_train

</td>

<td>

variable storing activity labels of train subject in `./UCI HAR
Dataset/train/y_train.txt`

</td>

</tr>

<tr>

<td valign="top">

set\_test

</td>

<td>

variable storing signal data for test in `./UCI HAR
Dataset/test/X_test.txt`

</td>

</tr>

<tr>

<td valign="top">

set\_train

</td>

<td>

variable storing signal data for train in `./UCI HAR
Dataset/train/X_train.txt`

</td>

</tr>

<tr>

<td valign="top">

subject\_test

</td>

<td>

variable storing test subject id of `./UCI HAR
Dataset/test/subject_test.txt`

</td>

</tr>

<tr>

<td valign="top">

subject\_train

</td>

<td>

variable storing train subject id of `./UCI HAR
Dataset/train/subject_train.txt`

</td>

</tr>

<tr>

<td valign="top">

test

</td>

<td>

intervening variable containing all test data

</td>

</tr>

<tr>

<td valign="top">

train

</td>

<td>

intervening variable containing all train data

</td>

</tr>

</table>

## The Key Pacakges and Functions

<table>

<tr>

<th>

Name

</th>

<th>

Description

</th>

</tr>

<tr>

<td valign="top">

`dplyr::arrange()`

</td>

<td>

`arrange()` order the rows of a data frame rows by the values of
selected columns.

</td>

</tr>

<tr>

<td valign="top">

`dplyr::as_tibble()`

</td>

<td>

`as_tibble()` turns an existing object, such as a data frame or matrix,
into a so-called tibble, a data frame with class tbl\_df.

</td>

</tr>

<tr>

<td valign="top">

`dplyr::bind_cols()`

</td>

<td>

This is an efficient implementation of the common pattern of
do.call(rbind, dfs) or do.call(cbind, dfs) for binding many data frames
into one.

</td>

</tr>

<tr>

<td valign="top">

`dplyr::bind_rows()`

</td>

<td>

This is an efficient implementation of the common pattern of
do.call(rbind, dfs) or do.call(cbind, dfs) for binding many data frames
into one.

</td>

</tr>

<tr>

<td valign="top">

`dplyr::mutate()`

</td>

<td>

`mutate()` adds new variables and preserves existing ones; `transmute()`
adds new variables and drops existing ones. New variables overwrite
existing variables of the same name. Variables can be removed by setting
their value to NULL.

</td>

</tr>

<tr>

<td valign="top">

`dplyr::select()`

</td>

<td>

Select (and optionally rename) variables in a data frame, using a
concise mini-language that makes it easy to refer to variables based on
their name (e.g. a:f selects all columns from a on the left to f on the
right). You can also use predicate functions like is.numeric to select
variables based on their properties.

</td>

</tr>

<tr>

<td valign="top">

`tidyr::pivot_longer()`

</td>

<td>

`pivot_longer()` “lengthens” data, increasing the number of rows and
decreasing the number of columns. The inverse transformation is
`pivot_wider()`.

</td>

</tr>

<tr>

<td valign="top">

`tidyr::pivot_wider()`

</td>

<td>

`pivot_wider()` “widens” data, increasing the number of columns and
decreasing the number of rows. The inverse transformation is
`pivot_longer()`.

</td>

</tr>

</table>
