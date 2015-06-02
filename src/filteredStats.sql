SELECT sub.status, 
  CAST(sub.status_total_length as BIGINT) as status_total_length, 
  CONCAT(FORMAT_NUMBER(CAST(sub.status_total_length as BIGINT) / CAST(${hiveconf:totalLength} as BIGINT) * 100, 10), "%") as percentage
FROM ( 
  SELECT status, SUM(size) as status_total_length 
  FROM tokenized_access_logs${hiveconf:tableNo}
  WHERE host = '${hiveconf:ip}'
  GROUP BY status
  ORDER BY status_total_length DESC
) sub;
