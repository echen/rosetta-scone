/* Build an inverted index!
 * 
 * An inverted index maps words to the documents
 * they appear in.
 * 
 * Run this in local mode with:
 *   pig -x local inverted-index.pig
 */

tweets = LOAD 'tweets.tsv' AS (tweet_id:int, text:chararray);

words = FOREACH tweets GENERATE tweet_id, FLATTEN(TOKENIZE(text)) AS word;
word_groups = GROUP words BY word;
inverted_index = FOREACH word_groups GENERATE group AS word, words.tweet_id;

STORE inverted_index INTO 'output.tsv';