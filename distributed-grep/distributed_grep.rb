# Grep big data using Hadoop Streaming (Ruby version)!
# To run on the command-line:
#   cat tweets.tsv | ruby distributed_grep.rb mapper | 
#     sort | ruby distributed_grep.rb reducer

PATTERN = /.*hello.*/

# Emit words that match the pattern.
def mapper
  STDIN.each_line do |line|
    puts line if line =~ PATTERN
  end
end

# Identity reducer.
def reducer
  STDIN.each_line do |line|
    puts line
  end
end

self.send(ARGV[0])