*** PLEASE CLICK "RAW" IN GITHUB TO SEE THE CORRECT FORMATTING OF THIS DOCUMENT ***

ANALYSIS OF Human Activity Recognition Using Smartphones Dataset, V1.0

This Code Book describes the variables, the data and the manipulations performed to clean up the data for Coursera "Getting and Cleaning Data" September 2015.

(1) The Experiment
	Data were collected from smartphones worn by 30 volunteers (ages 19-48) while they were performing 6 different activities, namely walking, walking upstairs, walking downstairs, sitting, standing, laying.  Detailed data from the accelerometer and gyroscope within the phone were used to capture movement data in X, Y, Z dimensions.  See "Variables" below for more details on the data collected.  The dataset was randomly divided into 70% training and 30% test.



(2) The Data
	The data were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on 2015-09-25 18:34:33 EDT. The zip file contains folders called test and train, each containing files "X_test.txt" (the data) "y_test.txt" (the labels) and "subject_test.txt" (volunteer ids) and the corresponding "train" files.  Each folder also contained an "Inertial Signals" folder which was not used for this analysis.  Also provided were a list of feature names "features.txt" and a description of the features "features.info.txt".  Finally, a codebook that gave the activity names and their numeric codes "activity_labels.txt" was also provided.  



(3) The Dataset Variables
	The following is a summary of features_info.txt:
From the accelerometer, the data collected was tAcc-XYZ where X,Y and Z are the dimensions and t is time.  tGyro-XYZ was collected from the gyroscope.  Both were captured at 50Hz and filtered to remove noise.  The acceleration signal tAcc-XYZ was separated into body acceleration tBodyAcc-XYZ and gravity acceleration tGravityAcc-XYZ.  Then Jerk signals were derived (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ) and the magnitude of these were calculated (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).  Some of the signals were fast Fourier transformed to produce variables fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag where f denotes frequency domain signal.  Features are normalized and bounded within [-1,1].  A more comprehensive description is found in features_info.txt and the dataset's README.txt.  
	For the purposes of this exercise, only the columns containing means and standard deviations were used.  These were denoted with mean() and std() in the variable name.  (Variables containing meanFreq() were excluded).  In total, 66 variables were examined (33 means and 33 std) and the final report contained only the averages (mean of means, approved in the Community Message Boards (https://class.coursera.org/getdata-032/forum/thread?thread_id=232).  

 [1] "subject"                     "activity"                   
 [3] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
 [5] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
 [7] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
 [9] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
[11] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
[13] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
[15] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
[17] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
[19] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
[21] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
[23] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
[25] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
[27] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
[29] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
[31] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
[33] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
[35] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
[37] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
[39] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
[41] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
[43] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
[45] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
[47] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
[49] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
[51] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
[53] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
[55] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
[57] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
[59] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
[61] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
[63] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
[65] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
[67] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 



(4) The run_analysis.R Variables and a description of the data processing

The test and training data, labels and subject identifiers were read in using read.table
	trainingSet		dataframe	X_train.txt		7352 obs of 563 variables
	trainingLabels		dataframe	y_train.txt		7352 obs of 1 variable
	trainingSubjects	dataframe	subject_train.txt	7352 obs of 1 variable	
	testingSet		dataframe	X_test.txt		2947 obs of 563 variables
	testingLabels		dataframe	y_test.txt		2947 obs of 1 variable
	testingSubjects		dataframe	subject_test.txt	2947 obs of 1 variable
	
Data organization and labeling:
	test  was derived by combining the columns (cbind) of testingSubjects, testingLabels and testingSet in that order.
	train was derived by combining the columns (cbind) of trainingSubjects, trainingLabels and trainingSet in that order.
	full_set was derived by combining the rows (rbind) of test and train. Total 10299 rows (7352 training + 2947 test) and 563 columns
		Column headers were "subject", "activity" and the variable names from featureNames (see below)
	featuresKey	dataframe containing features.txt, 561 rows and 2 columns
	featureNames	the second column of featuresKey containing the feature names, as a character vector of length = 561.
	namesMeanSD 	a character vector of length 68 containing "subject" "activity" 
			and the names of the 66 variables containing mean() or std() derived from names(full_set) 
	subsetMeanSD	a dataframe with 10299 rows and 68 columns, a subset of full_set with only the columns specified in namesMeanSD.
	activityLabels	activity_labels.txt.  Column 1 contains the numeric code and column 2 contains the names of the 6 activities.

Generation of the tidy dataset:
	tidyGathered	Takes subsetMeanSD and transfers all the variable names to a column called "column" 
			and all the values to a column called "value"  Result: 679734 rows, 4 columns
	tidyDDply	Takes tidyGathered and summarizes the data on columns "subject" "activity" and "column" and puts the mean value
			in new column called "calcmean"  Result: 11880 rows, 4 columns
	tidySeparated	Takes tidyDDply and separates (by the dash character) the three parts of "column" 
			into "measurement" "statistic" and "dimension"  Result: 11880 rows, 6 columns

	tidyFinal	Takes tidySeparated and keeps the half of the data where statistic = "mean".  Result: 5940 rows, 6 columns. 
			


(5) Reference for the Dataset

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

