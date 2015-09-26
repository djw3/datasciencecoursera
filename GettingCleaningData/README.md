*** PLEASE CLICK "RAW" IN GITHUB FOR CORRECT FORMATTING OF THIS DOCUMENT ***

This document explains how the scripts in runAnalysis.R work.
The code is also commented.

The goals of the script are to: 
	1. Read in and merge 2 datasets from the UCI Machine Learning Repository
	2. Extract the columns containing means and standard deviations
	3. Relabel the activities and variables for clarity
	4. Create a tidy dataset with the average of each variable for each activity and each subject.

The first chunk of code reads and examines the training dataset
	The "X-train.txt" file is read using read.table and stored in a variable called trainingSet.  The next 3 lines characterize trainingSet by checking its dimensions, structure and summary.  The activity labels ("y_train.txt") are read into variable trainingLabels and assigned a column name "activity". The subject labels ("subject_train.txt") are read into variable trainingSubjects.  Finally, the columns are combined using cbind in the order: trainingSubjects, trainingLabels, trainingSet.  The output is the dataframe "train".  

The second chunk of code reads and examines the test dataset in a similar manner, creating the dataframe "test".

The third chunk of code merges "train" and "test", and puts the variable names in the column headers.  The "features.txt" is read into a variable called featuresKey and the second column (featuresKey$V2) is extracted into a variable featureNames.  Variables train and test are merged using rbind and the column names (except column 1, subject, and column 2, activity) are assigned to their correct variable names from featureNames.

The fourth chunk of code extracts the mean and sd for each measurement.  The first and second columns are kept (grep "subject|activity") and the columns with mean and sd information are extracted by grep mean\\()|std\\().  It was important to grep the parentheses as well (instead of just the word "mean").  This required the escape characters \\.  The result of this was to remove the columns with meanFreq and keep only the ones with mean() and std().  The merged dataset full_set is then subsetted to include only these columns.  The output is the dataframe "subsetMeanSD".

The fifth chunk of code saves the activity labels from "activity_labels.txt" into variable activityLabels.  The first column contains the number codes 1-6 and the second column contains the corresponding activity (sitting, walking etc.)  The number codes in the activity column (column 2) of subsetMeanSD are matched to the number codes in first column of activityLabels and switched to the activity names instead.  The result is the name of the activity in column 2 of subsetMeanSD instead of the numbered activity code.


The sixth chunk of code creates the tidy dataset with the average of each variable for each activity and each subject.  Libraries tidyr and dplyr are loaded.  The next 2 lines of code are needed to make the column names formatted in a uniform way.  Some of them have "mean()-X" (or -Y or -Z) at the end, and some only have mean().  Likewise with std.  Therefore gsub was used to find instances of mean() and std at the end of the string (using $) and replace with mean-none and std-none.  This results in all the variable names having a uniform format of measurement-statistic-dimension, which will make it much easier in the next step to separate the column into the three parts.

To create the tidy dataset:

(1) 'gather' is used to bring the variable names (format: measurement-statistic-dimension) into one column.  
	  subject activity            column     value
	1       1 STANDING tBodyAcc-mean()-X 0.2885845
	2       1 STANDING tBodyAcc-mean()-X 0.2784188

(2) 'ddply' is used to summarize the values by variable, and put the averaged values into a column called calcmean.  
 	 subject activity            column    calcmean
	1       1   LAYING tBodyAcc-mean()-X  0.22159824
	2       1   LAYING tBodyAcc-mean()-Y -0.04051395

(3) 'Separate' is used to separate the three parts of the variables into separate columns.  
	  subject activity measurement statistic dimension    calcmean
	1       1   LAYING    tBodyAcc      mean         X  0.22159824
	2       1   LAYING    tBodyAcc      mean         Y -0.04051395

(4) 'spread' is used to spread out the activities into columns for easier viewing
  subject measurement statistic dimension     LAYING    SITTING   STANDING     WALKING  WALKING_DOWNSTAIRS WALKING_UPSTAIRS
1       1    fBodyAcc      mean         X -0.9390991 -0.9796412 -0.9952499 -0.20279431	       0.038229183      -0.40432178
2       1    fBodyAcc      mean         Y -0.8670652 -0.9440846 -0.9770708  0.08971273         0.001549908      -0.19097672
3       1    fBodyAcc      mean         Z -0.8826669 -0.9591849 -0.9852971 -0.33156012        -0.225574472      -0.43334970
4       1    fBodyAcc       std         X -0.9244374 -0.9764123 -0.9960283 -0.31913472         0.024330839      -0.33742819
5       1    fBodyAcc       std         Y -0.8336256 -0.9172750 -0.9722931  0.05604001	      -0.112963740       0.02176951
6       1    fBodyAcc       std         Z -0.8128916 -0.9344696 -0.9779373 -0.27968675        -0.297927895       0.08595655

(5) The final step is to remove the rows where statistic = 'std' because we only want to look at the mean of means.

