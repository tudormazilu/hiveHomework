CREATE EXTERNAL TABLE intermediate_access_logs2 (
  host STRING,
  identity STRING,
  user STRING,
  time STRING,
  request STRING,
  status STRING,
  size STRING,
  referer STRING,
  agent STRING)
 ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
 WITH SERDEPROPERTIES (
 'input.regex' = '([^ ]*) ([^ ]*) ([^ ]*) (-|\\[[^\\]]*\\]) (".*") (-|[0-9]*) (-|[0-9]*) (".*") (".*")?',
 'output.format.string' = "%1$s %2$s %3$s %4$s %5$s %6$s %7$s %8$s %9$s"
 )
 LOCATION '/user/bigData/logsProcessing/input';

CREATE EXTERNAL TABLE tokenized_access_logs2 (
 host STRING,
  identity STRING,
  user STRING,
  time STRING,
  request STRING,
  status STRING,
  size STRING,
  referer STRING,
  agent STRING)
 ROW FORMAT DELIMITED
 LOCATION '/user/bigData/logsProcessing/tokenized_access_logs';

ADD JAR /usr/lib/hive/lib/hive-contrib.jar;

INSERT OVERWRITE TABLE tokenized_access_logs2 SELECT * FROM intermediate_access_logs2;






