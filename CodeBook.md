run_analysis.R is a script to prepare tidy data that can be used for later analysis

Download the UCI HAR Dataset.

Assign each dataset to a data frame (features & activity_labels)

features <- features.txt : 561 rows, 2 variables 
List of all features for this database come from the tAcc-XYZ and tGyro-XYZ (accelerometer and gyroscope).

activity_labels <- activity_labels.txt : 6 rows, 2 variables 
List of activities performed while wearing a smartphone (Samsung Galaxy S II) on the waist.

X_test <- X_test.txt : 2947 rows, 561 columns contains recorded features test data 
X_train <- X_train.txt : 7352 rows, 561 columns contains recorded features training data 
Y_test <- Y_test.txt : 2947 rows, 1 columns contains test data of activities’code labels 
Y_train <- Y_train.txt : 7352 rows, 1 columns contains training data of activities’code labels 
subject_test <- subject_test.txt : 2947 rows, 1 column contains test data of 9/30 volunteer test subjects being observed 
subject_train <- subject_train.txt : 7352 rows, 1 column contains the subject who performed the activity for each window sample (1-30)

Merge training and test data sets to be in one dataset "merged_data" (10299 rows, 561 observations) is created by merging x_train and x_test using rbind() function 

Extracts only the measurements on the mean and standard deviation for each measurement "merged_data" (10299 rows, 79 columns) is created by subsetting merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Uses descriptive activity names to name the activities in the data set Entire numbers in code column of the Tidy_Dataset replaced with corresponding activity taken from second column of the activities variable

Appropriately labels the data set with descriptive variable names code column in Tidy_Dataset renamed into activities All Acc in column’s name replaced by Accelerometer All Gyro in column’s name replaced by Gyroscope All BodyBody in column’s name replaced by Body All Mag in column’s name replaced by Magnitude All start with character f in column’s name replaced by Frequency All start with character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject Final_Result (180 rows, 88 columns) is created by sumarizing Tidy_Dataset taking the means of each variable for each activity and each subject, after groupped by subject and activity. Export Final_Result into Final_Result.txt file.
