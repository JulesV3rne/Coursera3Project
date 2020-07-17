# Readme

This project includes a script `run_analysis.R` which takes a raw dataset and turns it into a clean dataset using the principles of tidy data. Through the following steps:

1. Downloads the dataset. Can also be manually downloaded from `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`
2. Merges all of the data into a single data table
3. Extracts the columns based on mean and standard deviation measurements
4. Cleans up variable and column names
5. Outputs the data to `tidy_data.txt`

# Prerequisites

None. The script `run_analysis.R` takes care of everything from downloading the dataset, making sure the required libraries are installed, and unzipping the dataset to the working directory.