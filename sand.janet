(use jaylib)

(import ./matrix)
(import ./element)

(def rows 256)
(def cols 256)
(def matrix (matrix/new rows cols))

(init-window rows cols "Test Game")
(set-target-fps 60)
(show-cursor)

(begin-drawing)

(while (not (window-should-close))
  (clear-background [0 0 0])
  (draw-fps 50 50)

  (if (mouse-button-pressed? :left)
    (let [[x y] (get-mouse-position)]
      (matrix/place-element matrix (math/floor x) (math/floor y) (element/new :sand))))

  (matrix/step matrix)
  (matrix/render matrix draw-pixel)

  (end-drawing))

(close-window)
