
# CodeBook

The included file run_analysis.R performs a series of operations required to go from a raw dataset to a tidy output data file. The data in question is taken from the kinetic sensors of wearable device.

### Preparing the environment

First the script checks if the pre-requisite libraries are installed, and downloads them if they are not. The required libraries are `dplyr` and `mgsub`. Then it downloads the necessary dataset from a static link and extracts the contents to a /data/ subfolder.

### Loading the variables

The script then reads all of the relevant data into memory to perform operations on. The script has been written with memory constraints in mind, so unused variables are unloaded once no longer required

### Merging the dataset

The activity and subject features are appended to the data column-wise and the test and training data are appended row-wise to complete the dataset. 

### Making the features human readable

The column names are replaced with more readable names, and then filtered further for consistency. The numerical categories associated with the activity are replaced with a named character factor.

### Layout, means, and final output

The data is grouped by both subject ID and activity type, and all the means are taken for each bin of variables. The data is sorted primarily by activity and secondarily by subject. The output is then written to ```tidy_data.txt``` in the working directory.

The variables produced by this script are:
- Subject
- Activity
- For each of the following, the mean and standard deviation of each variable in the X, Y, and Z directions
  - TimeBodyAcc
  - TimeGravityAcc
  - TimeBodyAccJerk
  - TimeBodyGyro
  - TimeBodyGyroJerk
  - FrequencyBodyAcc
  - FrequencyBodyAccJerk
  - FrequencyBodyGyro
- For each of the following, the mean and standard deviation of each variable
  - TimeBodyAccMag
  - TimeGravityAccMag
  - TimeBodyAccJerkMag
  - TimeBodyGyroMag
  - TimeBodyGyroJerkMag
  - FrequencyBodyAccMag
  - FrequencyBodyBodyAccJerkMag
  - FrequencyBodyBodyGyroMag
  - FrequencyBodyBodyGyroJerkMag