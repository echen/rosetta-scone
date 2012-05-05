-- Count words in Hive.

CREATE TABLE tweets (text STRING);
LOAD DATA LOCAL INPATH 'tweets.tsv' OVERWRITE INTO TABLE tweets;

SELECT word, COUNT(*) AS count
FROM (
  SELECT TRANSFORM(text) USING 'python tokenizer.py' AS word
  FROM tweets
) t
GROUP BY word;