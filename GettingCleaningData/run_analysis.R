# This code reads in data from the UCI Machine Learning Repository on activity
# measurements of 30 people wearing smartphones attached to their waists.  Output is 
# a tidy dataset for the Getting and Cleaning Data Coursera course Sept 2015.

# Read in and examine the training dataset
     trainingSet <- read.table('./train/X_train.txt')
     dim(trainingSet)
     str(trainingSet)
     summary(trainingSet)
     trainingLabels <- read.table('./train/y_train.txt')
     names(trainingLabels) <- 'activity'
     dim(trainingLabels)
     trainingSubjects <- read.table('./train/subject_train.txt')
     names(trainingSubjects) <- 'subject'
     dim(trainingSubjects)
     train <- cbind(trainingSubjects, trainingLabels, trainingSet)

 
# Read in and examine the test dataset
     testingSet <- read.table('./test/X_test.txt')
     dim(testingSet)
     str(testingSet)
     summary(testingSet)
     testingLabels <- read.table('./test/y_test.txt')
     names(testingLabels) <- 'activity'
     dim(testingLabels)
     testingSubjects <- read.table('./test/subject_test.txt')
     names(testingSubjects) <- 'subject'
     dim(testingSubjects)
     test <- cbind(testingSubjects, testingLabels, testingSet)

# Merge the training and test datasets
# Appropriately label the data set with descriptive variable names. 
# Note the variable names will be further clarified in the tidy dataset
     featuresKey <- read.table('./features.txt')
     featureNames <- as.character(featuresKey$V2)
     full_set <- rbind(train, test)
     names(full_set)[3:563] <- featureNames

# Extract the mean and sd for each measurement
     namesMeanSD <- grep("subject|activity|mean\\()|std\\()",names(full_set), value=TRUE)
     subsetMeanSD <- full_set[,namesMeanSD]   

# Use descriptive activity names to name the activities in the data set
     activityLabels <- read.table('./activity_labels.txt')
     subsetMeanSD[[2]] <- activityLabels[,2][match(subsetMeanSD[[2]], activityLabels[,1])]
      
# Create a tidy dataset with the average of each variable for each activity and each subject
     library(tidyr)
     library(plyr)
     # makes the colnames uniform format : measurement-statistic-dimension
     names(subsetMeanSD)  <- gsub("mean$", "mean-none", names(subsetMeanSD))
     names(subsetMeanSD)  <- gsub("std$", "std-none", names(subsetMeanSD))
     
     tidyGathered <- gather(data = subsetMeanSD, column, value, -subject, -activity)
     tidyDDply <- ddply(tidyGathered, .(subject, activity, column), summarize, calcmean = mean(value, na.rm=TRUE))
     tidySeparated <- separate(data = tidyDDply, col = column, into = c('measurement', 'statistic', 'dimension'))
     tidyFinal <- subset(tidySeparated, statistic == 'mean')
     tidyFinal
               