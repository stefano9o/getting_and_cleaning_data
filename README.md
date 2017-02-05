# Getting and Cleaning Data Project
This is the final project of the course "Getting and Cleaning Data"

## Source of data
The raw data which has to be tidy is from the Smartlab laboratory of the Università of Genoa (which is the same university where i studied, what a coincidence xD).

For more information:
* here it can be found information about the experiment http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions#
* here it can be found the zip file of the raw dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Analysis phase
`run_analysis.R` description:

1. download the zip file and decompress it only if they don't exist yet;
2. read all the datasets:
  1. activity name;
  2. feature name, only those related to mean and standard deviatione meseuramentes;
    1. clean the feature name in order to have descriptive variable names;
  3. feature values, subjects and activities for the test part;
  4. feature values, subjects and activities for the train part;
3. create the `test.df` and `train.df` dataframes binding the feature values, subjects and activities;
4. merge the test and train dataframes in order to create the `total` dataframe;
5. create the `totalMean` dataframe that contain the average of each variable for each activity and each subject;
6. write the `totalMean` dataframe just created in the `tidy.txt` file.
