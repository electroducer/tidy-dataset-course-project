## run_analysis.r was written as part of a peer-assessed assignment for
#  "Getting and Cleaning Data" from JHU.
#
# run_analysis() outputs tidy data summarising a large collection of motion
# data. Specifically, the means and standard deviations of each measurement
# are presented themselves as means for each subject and activity performed.
# Details can be found in the accompanying README and CODEBOOK files.

# NOTE: This script assumes that the UCI HAR Dataset can be found in a 
# directory of the same name in the working directory. A custom location can
# be specified by changing the 'data_dir' variable.

# Required packages: dplyr


run_analysis <- function() {
  
  library(dplyr)
  
  # Data directory path: Please change if data is stored in different location
  data_dir <- "UCI HAR Dataset/"
  
  # Load labels to memory
  fnames <- read.table(paste(data_dir, "features.txt", sep = ""))
  activity_labels <- read.table(paste(data_dir, "activity_labels.txt", sep = ""))
  
  # Preprocess the feature names by removing parentheses
  # This was done to declutter names and comply with table naming limits
  fnames <- sapply(fnames[,2], gsub, pattern = "\\(|\\)", replacement = "")
  
  # Load remaining data, inserting variable names (Requirement 4)
  X_train <- read.table(paste(data_dir, "train/X_train.txt", sep = ""),
                        col.names = fnames)
  X_test <- read.table(paste(data_dir, "test/X_test.txt", sep = ""),
                       col.names = fnames)
  y_train <- read.table(paste(data_dir, "train/y_train.txt", sep = ""),
                        col.names = "y")
  y_test <- read.table(paste(data_dir, "test/y_test.txt", sep = ""),
                       col.names = "y")
  subj_train <- read.table(paste(data_dir, "train/subject_train.txt", sep = ""),
                           col.names = "subject")
  subj_test <- read.table(paste(data_dir, "test/subject_test.txt", sep = ""),
                          col.names = "subject")
  
  # Combine the the data into one table (Requirement 1)
  xy_train <- bind_cols(subj_train, y_train, X_train)
  xy_test <- bind_cols(subj_test, y_test, X_test)
  data <- bind_rows(xy_train, xy_test)
  
  # Extract only means and stds (Requirement 2)
  data <- select(data, contains("mean"), contains("std"), y, subject)
  
  # Apply activity names to the y labels (Requirement 3)
  data <- mutate(data, activity = factor(y, labels = activity_labels[,2]))
  data <- select(data, -y)
  
  # Create the second summary dataset (Requirement 5)
  tidy <- group_by(data, subject, activity) %>% summarise_each(funs(mean))
}