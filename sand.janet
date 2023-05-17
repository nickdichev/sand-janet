(use jaylib)

(import ./matrix)
(import ./element)

(def rows 1024)
(def cols 1024)
(def matrix (matrix/new rows cols))

(for c 100 500 (matrix/place-element matrix 100 c (element/new :sand)))
(for c 200 600 (matrix/place-element matrix 300 c (element/new :water)))
(for c 300 700 (matrix/place-element matrix 500 c (element/new :brick)))

(init-window rows cols "Test Game")
(set-target-fps 60)
(show-cursor)

(begin-drawing)
(while (not (window-should-close))
  (matrix/render matrix)
  (end-drawing))
(close-window)
