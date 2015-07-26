I divide this assignment into 4 parts.

The first part is to read data into R. There are 8 txt files. I read them into varibles with the same names as the txt files.

The second part is to merge the dataframes and rename the columns and the activities.
I change the order because I think it will introduce troubles if extracting the measurements on the mean and standard deviation
for each measurement first.
I add two columns to the left of X_train, which are activity(y_train) and subject(subject_train).
Do the same thing with test
And then put this two part, so that I get a dataframe with 10299 rows(7352 from train + 2947 from test) and 563
colunms(activity,subject and 561 measurements)
Then rename the dataframe with "activity","subject" and 561 measurements from 'features'
Finally rename the activity with descriptive names such as 'LAYING' ect. from activity_labels

The third part is to restrain the measurements into mean and std only.
I find in the FAQ thread that the definition of mean and std is:
Based on interpreting column names in the features is an open question as to is the the entries that include mean() and std() at the end, or does it include entries with mean in an earlier part of the name as well. There are no specific marking criteria on the number of columns. It is up to you to make a decision and explain what you did to the data. Make it easy for people to give you marks by explaining your reasoning.
So I just search 'mean' and 'std' in the header of the dataset. I get 79 items.
Totally 81 combining with the activity and subject columns.
I notice that there are also 'Mean', however, 'Mean's are contained in items such as angle(Y,gravityMean).
They are names of a function instead of means of a measurements. So I just omit them.

The fourth part is to make the second dataset.
In order to use dcast function, I melt the dataframe into narrow dataset first.
But I find a problem that in dcast function, to the left of '~', I can only put one column of the dataframe.
I don't know if there is a function or an argument to solve this problem. I get another way.
I notice that the index of the activities ranges from 1 to 6 and the index of subjects range from 1 to 30. So if I put them
together,say, index of the activities multiplies by 100 and then plus the index of subjects, I get an unique factor vector
and I just put it to the left of '~'
Then I get a 180 row(6 activities * 30 subjects) by 80 columns(the factor vector +79 measurements)
At last, I decompose the factor vector so that I get back the activity and the subject.

Write into a txt file.
