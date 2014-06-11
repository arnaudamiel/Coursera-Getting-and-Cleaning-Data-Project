#Script for the project for the Coursera course Getting and Cleaning Data
#https://www.coursera.org/course/getdata

#Load Data
#We assume data was extracted in 'UCI HAR Dataset' directory structure
# together with this script in the working directory
#If not the script will error while trying to read data
print("Reading data")

features <- read.table(file.path("UCI HAR Dataset", "features.txt"))
activity_labels <- read.table(file.path("UCI HAR Dataset", "activity_labels.txt"))
subject_train <- read.table(file.path("UCI HAR Dataset", "train", "subject_train.txt"))
subject_test <- read.table(file.path("UCI HAR Dataset", "test", "subject_test.txt"))
y_train <- read.table(file.path("UCI HAR Dataset", "train", "y_train.txt"))
y_test <- read.table(file.path("UCI HAR Dataset", "test", "y_test.txt"))
X_train <- read.table(file.path("UCI HAR Dataset", "train", "X_train.txt"))
X_test <- read.table(file.path("UCI HAR Dataset", "test", "X_test.txt"))

print("Processing complete data")

#Merge the test and train data
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

#Free some space in memory
rm(X_train, X_test, y_train, y_test, subject_train, subject_test)

#Label the columns properly
names(X) <- features[ , 2]
names(y) <- "Activity"
names(subject) <- "Subject"

#Name activities and use them as Factors
y[ , ] <- activity_labels[y[ , ] , 2]
y[ , ] <- factor(y[ , ], levels=activity_labels[ , 2], ordered=TRUE)

#Make subject as Factors
subject[ , ] <- as.factor(subject[ , ])

#Merge all the data in one large data frame
#Sort it by Subject and Activity
Dataset <- cbind(subject, y, X)
Dataset[] <- Dataset[order(Dataset$Subject, Dataset$Activity) , ]

#Release some memory
rm(features, activity_labels, subject, X, y)

print("Creating Dataset1")

#Select only mean and STD columns for X
Wanted.Columns <-  grep("(mean\\(\\)|std\\(\\))", colnames(Dataset))
#Add subject and Activity columns
Wanted.Columns <- c(1 , 2, Wanted.Columns)
Dataset1 <- Dataset[ , Wanted.Columns]

print("Writing File Dataset1.csv")

#Output the data if the file does not exist already
if ( !file.exists("Dataset1.csv") )
  write.table(Dataset1,"Dataset1.csv" ,sep=",", row.names=FALSE)
  
#Release some memory
rm(Wanted.Columns)
  
print("Creating Dataset2")

#Calculate the mean grouped by subject and activity
Dataset2 <- aggregate(Dataset[-c(1, 2)], list(Dataset$Subject, Dataset$Activity), mean)
#Adjust headings
column.names <- paste(colnames(Dataset2), "AVERAGE", sep="-")
column.names[1] <- "Subject"
column.names[2] <- "Activity"
colnames(Dataset2) <- column.names

print("Writing File Dataset2.csv")

#Output the data if the file does not exist already
if ( !file.exists("Dataset2.csv") )
  write.table(Dataset2, "Dataset2.csv", sep=",", row.names=FALSE)
  
#Release some memory
rm(column.names)
  
print("Script completed")
