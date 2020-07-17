if(!require(dplyr)) {
  install.packages("dplyr")
}
if(!require(mgsub)) {
  install.packages("mgsub")
}

library(dplyr)
library(mgsub)

#Checks if the dataset exists. If not, downloads and extracts it
if (!file.exists("data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                destfile = "data.zip")
  unzip("data.zip", exdir = "./data/")
}


#Read all tables into memory
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

s_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
s_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Merge the tables into a single dataset
merged_data <- cbind(rbind(s_train, s_test), rbind(y_train, y_test), rbind(x_train, x_test))

#Remove unneeded temporary variables from memory
rm(x_test, x_train, y_test, y_train, s_test, s_train)


#Read in feature names and assign to columns
features <- read.table("./data/UCI HAR Dataset/features.txt")[[2]]
names(merged_data) <- c("Subject", "Activity", features)

#Extracts the indices for mean and std features and subset the data based off it
pattern = "mean\\(\\)|std\\(\\)"
mean_std <- grep(pattern, names(merged_data), ignore.case = TRUE)
mean_std <- c(1,2,mean_std) #Include prefix binded Subject and Activity cols
merged_data <- merged_data[,mean_std]

#Replace numeric variable with descriptive activity name 
act <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
lapply(merged_data["Activity"], function(x) {merged_data["Activity"] <<- act[x,2]})

#Group data, performing mean operation on each Subject/Activity pair
tidy <- summarise_all(group_by(merged_data,Activity,Subject), mean)

#Remove unneeded variables
rm(merged_data, act, features, mean_std, pattern)

#Cleaning column names, making them more human readable
names(tidy) <- mgsub(names(tidy), c("\\(", "\\)", "^t", "^f"), c("","", "Time", "Frequency"))

#Output to file
write.table(tidy, "tidy_data.txt")