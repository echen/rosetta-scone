# Count words using Hadoop Streaming (Ruby version)!
# To run on the command-line:
#   cat tweets.tsv | ruby word_count.rb mapper | sort | ruby word_count.rb reducer

# Emit (word, count) pairs.
def mapper
  STDIN.each_line do |line|
    line.split.each do |word|
      puts [word, 1].join("\t")
    end
  end
end

# Aggregate all (word, count) pairs for a particular word.
#
# In Hadoop Streaming (unlike standard Hadoop), the reducer receives
# rows from the mapper *one at a time*, though the rows are guaranteed
# to be sorted by key (and every row associated to a particular key
# will be sent to the same reducer).
def reducer
  curr_word = nil
  curr_count = 0
  STDIN.each_line do |line|
    word, count = line.strip.split("\t")
    if word != curr_word
      # New key.
      puts [curr_word, curr_count].join("\t")
      curr_word = word
      curr_count = 0
    end
    curr_count += count.to_i
  end
  
  puts [curr_word, curr_count].join("\t") unless curr_word.nil?
end

self.send(ARGV[0])