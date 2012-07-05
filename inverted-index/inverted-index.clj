;;;; Invert index in Cascalog.

;; bootstrap
(use 'cascalog.playground)(bootstrap)

;; define the data
(def index [
  [0 "Hello World"]
  [101 "The quick brown fox jumps over the lazy dog"]
  [42 "Answer to the Ultimate Question of Life, the Universe, and Everything"]
])

;; the tokenize function
(defmapcatop tokenize [text]
  (seq (.split text "\\s+")))

;; ensure inverted index is distinct per word
(defbufferop distinct-vals [tuples]
  (list (set (map first tuples))))

;; run the query on data
(?<- (stdout) [?word ?ids]
        (index ?id ?text)
        (tokenize ?text :> ?word)
        (distinct-vals ?id :> ?ids))