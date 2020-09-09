### 1 - Merging the training and the test sets to create one dataset

# Loading the datasets

subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt', col.names = 'subject_id')
X_train <- read.table('UCI HAR Dataset/train/X_train.txt')
Y_train <- read.table('UCI HAR Dataset/train/Y_train.txt', col.names = 'activity_id')
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt', col.names = 'subject_id')
X_test <- read.table('UCI HAR Dataset/test/X_test.txt')
Y_test <- read.table('UCI HAR Dataset/test/Y_test.txt', col.names = 'activity_id')

# Combining the column of the test and train datasets

train_df <- cbind(subject_train, Y_train, X_train)
test_df <- cbind(subject_test, Y_test, X_test)

# Stacking the train and test datasets on top of each other

complete_df <- rbind(train_df, test_df)




### 2 - Extracting only the measurements on the mean and standard deviation for each measurement

# Loading the features table

features <- read.table('UCI HAR Dataset/features.txt', col.names = c('feature_id', 'feature_label'))

# Finding the id of the labels that contain 'mean()' or 'std()' and adding 2 so that they correspond to the right column index in the complete dataset

labelsID <- grep('mean\\(\\)|std\\(\\)', features$feature_label) + 2

# Keep only the relevant columns in the complete dataset

complete_df <- subset(complete_df, select = c(1, 2, labelsID))




### 3 - Using descriptive activity names to name the activities in the dataset

# Loading the activity id/labels table

activities <- read.table('UCI HAR Dataset/activity_labels.txt', col.names = c('activity_id', 'activity_label'))

# Adding the activity labels to the dataset and removing the activity ids

complete_df <- merge(activities, complete_df, by = 'activity_id')
complete_df <- subset(complete_df, select = -activity_id)




### 4 - Appropriately labeling the dataset with descriptive variable names

# Extracting the feature labels that are needed
features_id_to_keep <- grep('mean\\(\\)|std\\(\\)', features$feature_label)
features_labels_to_keep <- features$feature_label[features_id_to_keep]

# Creating a vector to replace the column names
descriptive_variable_names <- c('activity_label', 'subject_id', features_labels_to_keep)

# Replacing the column names with descriptive variable names
colnames(complete_df) <- descriptive_variable_names




### 5 - From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject

# Creating the tidy dataset with the averages
tidy_df <- aggregate(. ~activity_label + subject_id, complete_df, mean)

# Ordering the new dataset by activity label and subject id
tidy_df <- tidy_df[order(tidy_df$activity_label, tidy_df$subject_id),]

# Saving the result as a txt file
write.table(tidy_df, "tidy_df.txt", row.name=FALSE)














