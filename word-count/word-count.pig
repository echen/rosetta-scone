/* Count words in Pig!
 * 
 * Run this in local mode with:
 *   scald.rb --local WordCount.scala
 */

tweets = LOAD 'tweets.tsv' AS (text:chararray);

words = FOREACH tweets GENERATE FLATTEN(TOKENIZE(text)) AS word;
word_groups = GROUP words BY word;
word_counts = FOREACH word_groups GENERATE group AS word, COUNT(words) AS count;

STORE word_counts INTO 'output.tsv';