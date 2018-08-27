setwd("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment")

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","dataset.zip")

library(dplyr)

#features
features <- read.table("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment/UCI HAR Dataset/features.txt")
#activity Labels
activity_labels <-read.table("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment/UCI HAR Dataset/activity_labels.txt")
#test
subject_test <- read.table("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment/UCI HAR Dataset/test/subject_test.txt")
test <- read.table("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment/UCI HAR Dataset/test/y_test.txt")
#train
subject_train <- read.table("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment/UCI HAR Dataset/train/subject_train.txt")
train <- read.table("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment/UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("C:/Users/cgoli/Documents/Coursera/3. Getting and Cleaning Data/Assignment/UCI HAR Dataset/train/y_train.txt")

#bind data sets
X <- rbind(train,test)
Y <- rbind(train_labels,test_labels)
colnames(X) <- features$V2

#just get means and stds
subject <- rbind(subject_train,subject_test)
means_stds <- X[,grep("mean\\(|std",colnames(X))]

#Add the activity labels
Y <- merge(Y, activity_labels, by = "V1", all.x = T )
colnames(Y) <- c("Activity", "ActivityName")
Data <-  cbind(Y,means_stds)
Data <- Data[,-1]
colnames(subject) <-  "Subject"
Data <- cbind(subject, Data)

#Final Tidy Data
write.csv(Data, "tidydata.csv")

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Data %>% group_by(Subject,ActivityName) %>% summarise_all(mean) -> Sum_Data
