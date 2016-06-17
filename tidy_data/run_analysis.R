## "Human Activity Recognition Using Smartphones Data Set"
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## !! Before running code, unzip dataset to the working directory

library(memisc)

## Read_custom with no header, sep = whitespace, and no factors variables
read_custom <- function(fname) {
  read.delim(fname, header = FALSE, sep = "", stringsAsFactors = FALSE)
}


## Feature names and activities
## ----------------------------
feature_names <- read_custom("UCI HAR Dataset/features.txt")
feature_names <- feature_names[, 2]
activity_names <- read_custom("UCI HAR Dataset/activity_labels.txt")
names(activity_names) <- c("id", "activity")


## Training dataset
## ---------------
x_train <- read_custom("UCI HAR Dataset/train/X_train.txt")
y_train <- read_custom("UCI HAR Dataset/train/y_train.txt")
subjects_train <- read_custom("UCI HAR Dataset/train/subject_train.txt")

train <- cbind(subjects_train, y_train, x_train)
names(train) <- c("subject", "activity", feature_names)
rm(x_train, y_train, subjects_train)


## Test dataset
## ------------
x_test <- read_custom("UCI HAR Dataset/test/X_test.txt")
y_test <- read_custom("UCI HAR Dataset/test/y_test.txt")
subjects_test <- read_custom("UCI HAR Dataset/test/subject_test.txt")

test <- cbind(subjects_test, y_test, x_test)
names(test) <- c("subject", "activity", feature_names)
rm(x_test, y_test, subjects_test)


## Make tidy dataset:
## Merge, label activites, select mean and sd features
##
## res = tidy data set with the average of each variable
##       for each activity and each subject.
## -----------------------------------------------------
res <- rbind(train, test)
res$activity <- factor(res$activity, 
                       levels = activity_names[, 1],
                       labels = activity_names[, 2])

cols <- grepl("mean\\(|std\\(", names(res))
res  <- res[, c(1, 2, which(cols))]


## Outputs
## -------

## Create codebook
Write(codebook(res), file = "Codebook.md")

## Save file
write.table(res, file = "tidy_data.txt", row.names = FALSE, quote = FALSE)
