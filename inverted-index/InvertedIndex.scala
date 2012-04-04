import com.twitter.scalding._

/** Build an inverted index!
  * 
  * An inverted index maps words to the documents
  * they appear in.
  * 
  * Run this in local mode with:
  *   scald.rb --local InvertedIndex.scala
  */
class InvertedIndex(args : Args) extends Job(args) {

  val tweets = Tsv("tweets.tsv", ('id, 'text))

  val wordToTweets =
    tweets
      .flatMap(('id, 'text) -> ('word, 'tweetId)) { 
        fields : (Long, String) => 
        val (tweetId, text) = fields
        text.split("\\s+").map { word => (word, tweetId) }
      }

  val invertedIndex =
    wordToTweets.groupBy('word) {  _.toList[Long]('tweetId -> 'tweetIds) }
    
  invertedIndex.write(Tsv("output.tsv"))
}