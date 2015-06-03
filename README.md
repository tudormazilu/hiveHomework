# Requirements
1.  Create a Hive managed table to store Apache log data.
Create a MapReduce job to parse text lines from Apache logs and insert them into Hive.
Write the stats job in HiveQL.
Compare the results with your previous results from the handcrafted MapReduce stats job.
2. Create a Hive external table directly on top of Apache text logs.
Run the stats job in HiveQL.
3. The "request URL" field in the Apache logs has strings that repeat often. Pull them into a separate table. (Create a Hive managed table for that purpose). Run the stats job using HiveQL but with a join.
Clarification for point 3. The stats job should print bandwidth stats _by URL_ instead of by status code. For bonus points, do a breakdown both by URL and status code :) The query result should include the full URL.

# Running the solution
In order to run the solution
1. Step 1
  - Copy log files into Hadoop at /user/bigData/logsProcessing/input
  - Run createTables1.sql
2. Step 2
  - Copy log files into Hadoop at /user/bigData/logsProcessing/input
  - Run createTables2.sql
3. Run hiveHomework.sh like this:
  - > ./hiveHomework.sh 1 IP //for point 1.
  - > ./hiveHomework.sh 2 //for point 2.
  - > ./hiveHomework.sh 3 //for point 3, full stats grouped on URL
  - > ./hiveHomework.sh 4 //for point 3, full stats grouped on URL and status code
