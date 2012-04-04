/* Grep! Distributed-ly!
 * 
 * Run this in local mode with:
 *   scald.rb --local DistributedGrep.scala
 */

%declare PATTERN '.*hello.*';

tweets = LOAD 'tweets.tsv' AS (text:chararray);
results = FILTER tweets BY (text MATCHES '$PATTERN');

STORE results INTO 'output.tsv';