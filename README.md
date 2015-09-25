# gettingandcleaningdata

<h2>Course Project</h2>

There is only one script in the repository - run_analysis.R.  There are several helper functions within the file that perform various actions, but all of these functions are called from the create_tidy_data_set() function, which itself is called when the script is run.

This function assumes that the working directory contains the UCI HAR Dataset .zip folder.  If the unpacked files from that directory are present in the working directory then the script will also run properly.  If the UCI HAR Dataset is not in the working directory in some fashion then the script will fail to run.

The output of the script is a txt file called "tidy_data_set.txt," which will appear in the working directory next to the script and UCI HAR Dataset.  The content of this file is described in the CodeBook.md file.  
