import com.twitter.scalding._

/** Grep! Distributed-ly!
  * 
  * Run this in local mode with:
  *   scald.rb --local DistributedGrep.scala
  */
class DistributedGrep(args : Args) extends Job(args) {

  val Pattern = ".*hello.*";

  Tsv("tweets.tsv", 'text)
    .filter('text) { text : String => text.matches(Pattern) }
    .write(Tsv("output.tsv"))    
}