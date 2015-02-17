
## libraries

library(tidyr)
library(dplyr)
library(reshape2)

## Set directory 
setwd("E://Projects//R//getdata-011//as1//UCI HAR Dataset")

## Read data files

d_Act_Test  <- read.table( "test//Y_test.txt"   ,header = FALSE)
d_Act_Train <- read.table( "train//Y_train.txt" ,header = FALSE)
d_Sub_Test  <- read.table( "test//subject_test.txt"   ,header = FALSE)
d_Sub_Train <- read.table( "train//subject_train.txt" ,header = FALSE)
d_Feat_Test <- read.table( "test//X_test.txt"  ,header = FALSE)
d_Feat_Train <- read.table("train//X_train.txt",header = FALSE)
d_Feat_Names <- read.table("features.txt",header = FALSE)
Act_Labels   <- read.table("activity_labels.txt",header = FALSE)

## 1. Merges the training and the test sets to create one data set

d_Act <- rbind(d_Act_Test,d_Act_Train)
d_Sub <- rbind(d_Sub_Test,d_Sub_Train)
d_Feat <- rbind(d_Feat_Test,d_Feat_Train)

rm(list=c("d_Act_Test","d_Act_Train","d_Sub_Test","d_Sub_Train","d_Feat_Test","d_Feat_Train"))

## Add column names

names(d_Act)  <- c("Activity")
names(d_Sub)  <- c("Subject")
names(d_Feat) <- d_Feat_Names[,2]
names(Act_Labels) <- c("Activity","ActivityName")

## 2. Extracts only the measurements on the mean and standard deviation for each measurement
d <- d_Feat[,grep("mean\\(\\)|std\\(\\)",d_Feat_Names[,2])]

## Marge data by comlumns

d <- cbind(d,d_Sub,d_Act)
rm(list=c("d_Feat","d_Sub","d_Act","d_Feat_Names"))

## 3. Uses descriptive activity names to name the activities in the data set

d <- merge(x=d,y=Act_Labels,by="Activity")

## 4. Appropriately labels the data set with descriptive variable names. 

names(d)<-gsub("^t", "time", names(d))            # t -> time
names(d)<-gsub("^f", "frequency", names(d))       # f -> frequency
names(d)<-gsub("Acc", "Accelerometer", names(d))  # Acc -> Accelerometer
names(d)<-gsub("BodyBody", "Body", names(d))      # BodyBody -> Body
names(d)<-gsub("Gyro", "Gyroscope", names(d))     # Gyro -> Gyroscope
names(d)<-gsub("Mag", "Magnitude", names(d))      # Mag -> Magnitude


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

d_rows <-  melt(d, id=c("Activity","ActivityName","Subject"))
d_avg  <-  dcast(data = d_rows, formula = Activity+ActivityName+Subject~variable, fun.aggregate = mean)

## Write the file

write.table(x = d_avg, file = "Dataset_out.txt", row.names = FALSE)

## END


