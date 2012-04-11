(defmapcatop tokenize [text]
  (seq (.split text "\\s+")))

  (defaggregateop conj-words
    ([] [])
    ([word-list word]
      (conj word-list word))
    ([word-list]
      [word-list]))


(defn inverted-index [input-filename]
  (let [input (hfs-textline input-filename)]
    (<- [?word ?tweet-ids]
        (input ?textline)
        (tokenize ?textline :> ?word)
        (conj-words ?tweet-ids))))

(?- (stdout) (word-count "tweets.tsv"))