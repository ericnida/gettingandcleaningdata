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
