(use jaylib)

(def matrix-x 1024)
(def matrix-y 1024)

(init-window matrix-x matrix-y "Test Game")
(set-target-fps 60)
(show-cursor)

(begin-drawing)
(clear-background [0 0 0])

(while (not (window-should-close))

  (if (mouse-button-pressed? :left) (let [[x y] (get-mouse-position)] (draw-pixel (math/floor x) (math/floor y) :yellow)))

  (end-drawing))

(close-window)
