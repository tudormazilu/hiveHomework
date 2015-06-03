SELECT sub.url, sub.status,
  CAST(sub.url_total_length as BIGINT) as url_total_length, 
  CONCAT(FORMAT_NUMBER(CAST(sub.url_total_length as BIGINT) / CAST(sub.total_length as BIGINT) * 100, 10), "%") as percentage
FROM ( 
  SELECT regexp_extract(a.request, '.* (.*) (.*)?', 1) as url, a.status, SUM(a.size) as url_total_length, b.total_length as total_length 
  FROM tokenized_access_logs2 a,
    (SELECT SUM(size) AS total_length from tokenized_access_logs2) b
  GROUP BY regexp_extract(a.request, '.* (.*) (.*)?', 1), a.status, b.total_length
  ORDER BY url ASC, url_total_length DESC
) sub;
