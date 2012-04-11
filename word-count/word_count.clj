;;;; Count words in Cascalog!

; Takes a single piece of text as input.
; Outputs a tuple for each word in the text.
(defmapcatop tokenize [text]
  (seq (.split text "\\s+")))

(defn word-count [input]
  (<- [?word ?count]
      (input ?textline)
      (tokenize ?textline :> ?word)
      (c/count ?count)))

(?- (stdout) (word-count (hfs-textline "tweets.tsv")))