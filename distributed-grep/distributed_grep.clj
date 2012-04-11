;;;; Distributed grep in Cascalog!

(def pattern #".*hello.*")

(deffilterop matches-pattern? [text pattern]
  (re-matches pattern text))

(defn distributed-grep [input pattern]
  (<- [?textline]
      (input ?textline)
      (matches-pattern? ?textline pattern)))

(?- (stdout) (distributed-grep (hfs-textline "tweets.tsv") pattern))