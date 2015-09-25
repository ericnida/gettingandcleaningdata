# run_analysis.R
# --------------
# Eric Nida

# Assumes UCI HAR Dataset zip folder is in the current working directory, unzips the data 
# and reads in applicable files.  Test and training data sets merged, labeled, and mean and
# std-related data extracted.  Creates a second, independent tidy data set with the average of
# each variable for each activity and each subject. Output is written to a txt file
create_tidy_data_set <- function() {
  unzip("getdata-projectfiles-UCI HAR Dataset.zip", overwrite = TRUE)
  
  test_data_file <- "./UCI HAR Dataset/test/X_test.txt"
  test_labels_file <- "./UCI HAR Dataset/test/y_test.txt"
  test_subject_file <- "./UCI HAR Dataset/test/subject_test.txt"
  train_data_file <- "./UCI HAR Dataset/train/X_train.txt"
  train_labels_file <- "./UCI HAR Dataset/train/y_train.txt"
  train_subject_file <- "./UCI HAR Dataset/train/subject_train.txt"
  features_file <- "./UCI HAR Dataset/features.txt"
  
  if (file.exists(test_labels_file)) {
    test_data_activities <- read.table(test_labels_file)
  }
  
  if (file.exists(test_subject_file)) {
    test_subject_data <- read.table(test_subject_file)
  }
  
  if (file.exists(train_labels_file)) {
    train_data_activities <- read.table(train_labels_file)
  }
  
  if (file.exists(train_subject_file)) {
    train_subject_data <- read.table(train_subject_file)
  }
  
  if (file.exists(test_data_file) && file.exists(train_data_file)) {
    training_data <- read.table(train_data_file)
    test_data <- read.table(test_data_file)

    test_data_labels <- rename_labels_with_activity(test_data_activities)
    test_data <- cbind(test_data, Activity=test_data_labels[,1])
    test_data <- cbind(test_data, Subject=test_subject_data[,1])
    
    train_data_labels <- rename_labels_with_activity(train_data_activities)
    training_data <- cbind(training_data, Activity=train_data_labels[,1])
    training_data <- cbind(training_data, Subject=train_subject_data[,1])
    
    full_data_set <- rbind(test_data, training_data)
    
    if (file.exists(features_file)) {
      features <- read.table(features_file, stringsAsFactors = FALSE)
    }
    full_data_set <- rename_columns(full_data_set, features)
  
    mean_and_std_data <- full_data_set[, grep("mean|std|Activity|Subject", names(full_data_set))]  
    final_result <- get_unique_means(mean_and_std_data)
  
    write.table(final_result, "tidy_data_set.txt", row.name=FALSE)
  } else {
    print("Error reading data from file")
  }
}

# Renames the single digit integers in the data_set parameter with the appropriate
# corresponding activity name from the activity_labels.txt file
rename_labels_with_activity <- function(data_set) {
  activity_label_file <- "./UCI HAR Dataset/activity_labels.txt"
  if (file.exists(activity_label_file)) {
    activity_labels <- read.table(activity_label_file, stringsAsFactors = FALSE)
    for (i in 1:6) {
      label <- activity_labels[i, 2]
      data_set[data_set == i] <- label
    }
    return(data_set)
  } else {
    print("Error reading activity_labels.txt")
  }
}

# Renames the columns of the given data_set with the corresponding value
# from the features.txt file
rename_columns <- function(data_set, features) {
  if (ncol(data_set) != nrow(features) + 2) {
    print("Cannot map names to columns; mismatch in lengths")
  } else {
    features_length <- nrow(features)
    for (i in 1:features_length) {
      names(data_set)[i] <- features[i, 2] 
    }
    return(data_set)
  }
}

# Given a data_set of merged test and training data, function returns a 
# tidy data set with the average of each variable for each activity
# and each subject in labeled columns
get_unique_means <- function(data_set) {
  subjects <- sort(unique(data_set$Subject))
  activities <- sort(unique(data_set$Activity))
  final_result <- NULL
  for (subject in subjects) {
    for (activity in activities) {
      temp_result <- NULL
      temp_result <- data_set[which(data_set$Subject == subject & data_set$Activity == activity), ]
      temp_result$Activity <- NULL
      temp_result$Subject <- NULL
      column_names <- colnames(temp_result)
      temp_result <- colMeans(temp_result)
      temp_result <- cbind(column_names, temp_result)
      temp_result <- cbind(activity, temp_result)
      temp_result <- cbind(subject, temp_result)
      final_result <- rbind(final_result, temp_result)
    }
    
  }
  colnames(final_result) <- list("Subject", "Activity", "Measurement", "Mean")
  return(final_result)
}

create_tidy_data_set()
