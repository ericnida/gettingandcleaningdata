# CodeBook.md

<h3>Study Design</h3>
The data used for the script in this repository is the UCI HAR Dataset, contained both in the repository and the following url:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Descriptions of the data and how it was collected are contained in the features_info.txt and README.txt files.

<h3>Codebook</h3>
The tidy_data_set.txt file contains following variables and measurements:

"Subject" - An integer valued between 1 and 30 (inclusive).  There were 30 subjects, age 18-49, that performed the activities for the accelerometer data measured, and each integer shows which subject performed the measurement.

"Activity" - The activity being performed by the subject for the given measurement. These are in human readable form, so each String activity represents the action being taken by the subject.

"Measurement" - the type of sensor signal (accelerometer and/or gyroscope) and measurement for the sensor signal.  As stated in the raw data set feature_info.txt file: 

"'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."

Prefix t denotes time.  As all data is either for mean or standard deviation, each measurement row will also show which of these two apply.  The raw dataset files README.txt and features_info.txt contain detailed information about the measurements and collection of the data.

"Mean" - the average value for each measurement for the subject and activity.  The value is the "Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration."  Each feature is normalized and bounded from [-1, 1].

<h3>Summary Choices</h3>
The first action performed is unzipping the raw data directory.  If the unzipped raw data is already in the working directory, then it will be overwritten by the same data.  The script assumes the raw data is in the working directory.

For both the test and training sets, the data file, labels file, and subject file are read as tables by the script.  In addition, the features file, which contains the names of the measurements, is also read as table.  For the test data and then the training data, the integer activities from the y_test.txt or y_train.txt files are renamed with the corresponding strings for each activity (i.e. WALKING, SITTING, etc.).  These renamed activities are added in an additional column to both the test and train data tables.  Next, the subject data, which are integers indicating the subject that performed each activity, are bound as another column to the test or train data tables.  Following this step, the two tables for the test data and train data were bound together to create a complete data set.

Once the full data set is combined, each column is renamed with the corresponding measurement name from the features.txt file.  From there, only the columns pertaining to mean and standard deviation are subsetted from the full data set, along with the columns for subject and activity.  The final, tidy data set is extracted from the full data set.  The rows of measurements for each subject and for each activity are subsetted, and colMeans() used to get the mean for each measurement for every activity for a given subject.  Each mean for a subject and activity is then bound to a final, clean table.  The columns are then renamed after this is complete.

The final step is to create a txt file named "tidy_data_set.txt", which is done using write.table with row.name=FALSE.
