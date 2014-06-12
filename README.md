Coursera Getting and Cleaning Data Project
==========================================

Script for Coursera Getting and Cleaning Data Project

This script, run_analysis.R, needs to be run in the working directory containing the unmodified unzipped data folder 'UCI HAR Dataset'.

The script will process the provided data and create 2 datasets and CSV files containing those datasets. In addition, a dataframe 'Dataset' will remain in memory at the end of the script that contains all the data read from the 'UCI HAR Dataset' folder. No CSV file will be output for 'Dataset'

Dataset1
--------
This dataset is a dataframe containing only the measurements on the mean and standard deviation for each measurement.
This is done by only keeping variables from the original dataset which name contains 'std()' or 'mean()'.
It is saved in the Dataset1.csv file if this file does not already exist.

Dataset2
--------
This dataset is a dataframe containing the average of each variable for each activity and each subject.
All variables keep the original name but have '-AVERAGE' appended to them.
It is saved in the Dataset2.csv file if this file does not already exist.
