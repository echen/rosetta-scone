# Create an inverted index using Hadoop Streaming 
# (Ruby version).
# 
# To run on the command-line:
#   cat tweets.tsv | ruby inverted_index.rb mapper | 
#     sort | ruby inverted_index.rb reducer

# Emit (word, tweet_id) pairs.
def mapper
  STDIN.each_line do |line|
    tweet_id, text = line.strip.split("\t")
    text.split.each do |word|
      puts [word, tweet_id].join("\t")
    end
  end
end

# Aggregate all (word, tweet_id) pairs for a particular word.
#
# In Hadoop Streaming (unlike standard Hadoop), the reducer receives
# rows from the mapper *one at a time*, though the rows are guaranteed
# to be sorted by key (and every row associated to a particular key
# will be sent to the same reducer).
def reducer
  curr_word = nil
  curr_inv_index = []
  STDIN.each_line do |line|
    word, tweet_id = line.strip.split("\t")
    if word != curr_word
      # New key.
      puts [curr_word, curr_inv_index.join(",")].join("\t")
      curr_word = word
      curr_inv_index = []
    end
    curr_inv_index << tweet_id
  end
  
  unless curr_word.nil?
    puts [curr_word, curr_inv_index.join(", ")].join("\t") 
  end
end

self.send(ARGV[0])