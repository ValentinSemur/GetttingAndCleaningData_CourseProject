
# Getting and Cleaning Data Course Project

The run_analysis.R file is already heavily commented, however here are the main points that it goes through



### 1 - Merging the training and the test sets to create one dataset

First the datasets are loaded onto RStudio  
Then the three columns of the train and test datasets are combined  
Finally both datasets (train and test) are stacked on top of each other in order to create only one dataset with everything  



### 2 - Extracting only the measurements on the mean and standard deviation for each measurement

First the text file that contains the features labels and IDs is loaded  
Then we find the ID of the labels that contain either mean() or std() (in RegEx it is 'mean\\(\\)|std\\(\\)', the backslashes are used to escape the parenthesis)  
In order for the ID to correspond to the column positions we add 2 to the vector (to skip the first two columns)  
Then using the ID vector, we select only the first two columns (activity and subject) and the columns containing a mean or a standard deviation measure  



### 3 - Using descriptive activity names to name the activities in the dataset

First the text file that contains the activities labels and IDs is loaded  
Then a merge is performed in order to add the activity labels as a column of the dataframe  
Finally the activity IDs column is removed as it is no longer needed  



### 4 - Appropriately labeling the dataset with descriptive variable names

First the features labels that are needed (mean and std) are extracted from the vector of feature labels  
Then a vector to replace the column names is created from which we add the feature labels to the activity label and subject id  
Finally the column names are replaced by this newly created vector  



### 5 - From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject

A tidy dataset that takees the average of each variable for each activity and subject is created  
Then this dataset is orderedd by activity label and subject ID in order to make it easier to read  
Finally this table is saved in a txt file  
