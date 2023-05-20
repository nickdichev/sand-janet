(use jaylib)

(import ./matrix)
(import ./element)

(def rows 256)
(def cols 256)

(def matrix (matrix/new rows cols))
(loop [r :range [0 rows]] (matrix/place-element matrix r (dec cols) (element/new :brick)))

(init-window rows cols "Test Game")
(set-target-fps 60)
(show-cursor)

(begin-drawing)

(while (not (window-should-close))
  (clear-background [0 0 0])
  (draw-fps 50 50)

  (let [[x y] (get-mouse-position)
        x (math/floor x)
        y (math/floor y)]
    (draw-circle x y 4 :light-gray)

    (if (mouse-button-down? :left)
      (matrix/place-element matrix x y (element/new :sand)))

    (if (mouse-button-down? :right)
      (matrix/place-element matrix x y (element/new :water))))

  (matrix/step matrix)
  (matrix/render matrix draw-pixel)

  (end-drawing))

(close-window)
