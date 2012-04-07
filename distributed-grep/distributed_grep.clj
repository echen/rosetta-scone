;;;; Distributed grep in Cascalog!

(def pattern #".*hello.*")

(deffilterop matches-pattern? [text pattern]
  (re-matches pattern text))

(defn distributed-grep [input-filename pattern]
  (let [input (hfs-textline input-filename)]
    (<- [?textline]
        (input ?textline)
        (matches-pattern? ?textline pattern))))

(?- (stdout) (distributed-grep "tweets.tsv" pattern))