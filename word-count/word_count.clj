;;;; Count words in Cascalog!

; Takes a single piece of text as input.
; Outputs a tuple for each word in the text.
(defmapcatop tokenize [text]
  (seq (.split text "\\s+")))

(defn word-count [input-filename]
	(let [input (hfs-textline input-filename)]
    (<- [?word ?count]
        (input ?textline)
        (tokenize ?textline :> ?word)
        (c/count ?count))))

(?- (stdout) (word-count "tweets.tsv"))