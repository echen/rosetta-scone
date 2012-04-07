# UDF to split text into words.
# Used by word-count.hql.

import sys

for line in sys.stdin:
  for word in line.split():
    print word
