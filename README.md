# tidy-dataset-course-project
A script that tidies and summarises a specific dataset for a peer-assessed course project.

The included R script is designed to simplify and summarise data from the 
"Human Activity Recognition Using Smartphones" Dataset
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The script assumes that the source data
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
is unzipped and found within a "UCI HAR Dataset" in the working directory.

Additionally, the script requires the dplyr package. 

Running r_analysis() will output a table that summarises the data by calculating the means
of all mean and standard deviation measurements for each subject and activity. The
variables are described in the accompanying CODEBOOK file.

e.g.
data <- r_analysis()
View(data)
saves the summary table to the 'data' variable and opens the table viewer for viewing.