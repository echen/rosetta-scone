/* Distributed grep.
 * 
 * Run this in local mode with:
 *   pig -x local distributed-grep.pig
 */

%declare PATTERN '.*hello.*';

tweets = LOAD 'tweets.tsv' AS (text:chararray);
results = FILTER tweets BY (text MATCHES '$PATTERN');

STORE results INTO 'output.tsv';