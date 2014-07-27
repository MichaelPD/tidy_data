#assumes working directory is already /.../UCI HAR Dataset

#creates table of readings data
table_readings <- read.table("test/X_test.txt")
table_readings <- rbind(table_readings, read.table("train/X_train.txt"))

#sets column names
table_readingsNames <- read.table("features.txt", stringsAsFactors=FALSE)
table_readings <- setnames(table_readings[seq_along(table_readingsNames$V2)],table_readingsNames$V2)

#selects columns to retain (remove all but mean & std)
meanORstd <- grepl("-mean\\(\\)|-std\\(\\)",table_readingsNames$V2)
#grep also gives meanFreq unless the \\ is used
#could also use fixed=TRUE
table_readings <- table_readings[,c(meanORstd)]

#creates table of subjects
table_subject <- read.table("test/subject_test.txt")
table_subject <- rbind(table_subject, read.table("train/subject_train.txt"))
colnames(table_subject) <- "subject"

#creates table of activities
table_activity <- read.table("test/y_test.txt")
table_activity <- rbind(table_activity, read.table("train/y_train.txt"))
colnames(table_activity) <- "activity"

#combines subject & activities with readings table
table_readings <- cbind(c(table_subject,table_activity),table_readings)

#add column of descriptive (string) names to activities table
table_activityLabels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
colnames(table_activityLabels) <- c("activity","activity_string")
table_readings <- merge(table_activityLabels, table_readings)

#removing non-string(int) activity column
table_readings <- table_readings[-1]

#set factors
table_readings$activity_string <- factor(table_readings$activity_string)
table_readings$subject <- factor(table_readings$subject)

#generate tidy data set - average of each variable for each activity and each subject.
#create empty table from table_readings
tidy_readings <- table_readings[1,][-1,]


for (i in levels(table_readings$subject)) {
    tempTable1 <- table_readings[table_readings$subject == i,]
    
    for (j in levels(table_readings$activity_string)){
        tempTable2 <- tempTable1[tempTable1$activity_string == j,]
        tempTableMean <- tempTable2[1,]
        calcMeanCol <- c(3:ncol(tempTableMean))#vector of columns to calc mean for
        for (k in calcMeanCol){
            tempTableMean[1,k] <- (sum(tempTable2[,k])/length(tempTable2[,k]))
        }
        tidy_readings <- rbind(tidy_readings,tempTableMean)
    }   
}

#tidy_readings is the tidy dataset
#export can be done via write.table


