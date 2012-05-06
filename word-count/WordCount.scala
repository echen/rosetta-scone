import com.twitter.scalding._

/**
 * Count words in Scalding.
 * 
 * Run this in local mode with:
 *   scald.rb --local WordCount.scala
 */
class WordCount(args : Args) extends Job(args) {

  Tsv("tweets.tsv", 'text)
    .flatMap('text -> 'word) { text : String => text.split("\\s+") }
    .groupBy('word) { _.size }
    .write(Tsv("output.tsv"))    
}
  