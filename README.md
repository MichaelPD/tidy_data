tidy_data
=========
Assignment for Coursera-Getting and Cleaning Data.

Utilizes dataset of accelerometer readings for 30 subjects performing 6 actions to accomplish the below steps (though done out of order/addressed in multiple steps):


1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement. 

3.Uses descriptive activity names to name the activities in the data set

4.Appropriately labels the data set with descriptive variable names. 

5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


This is all done via a single R script, run_analysis.R, which can be viewed as two sections:

lines 1-40 - merging, extracting, labeling to create 1 master 

  (1, as above)two data sets, test and train accelerometer readings, are merged via rbind
  
  (4)columns are labeled, based on "features.txt" provided in original dataset
  
  (2)columns not containing std() or mean() readings are removed
  
  (1)joining test&train data to create a subject table
  
  (1)joining test&train data to create an activity table
  
  (1)adding the subject & activity tables to the table of readings via cbind
  
  (3)adding descriptive names for activities, via merge
  

lines 41-60 - calculating an average value for each subject (30 values) and activity (6 values) to give a single tidy data table
  
  (5)The tidy data table consists of 180 rows (6*30), each of 2 identifying(factor) values (activity & subject) and 66       averaged measurement values (average of std or mean) - this satisfies step 5 from above.
