(use jaylib)

(import ./matrix)
(import ./element)

(def rows 256)
(def cols 256)
(def screen-width 1024)
(def screen-height 1024)
(def scale-factor 4)

(def matrix (matrix/new rows cols))
(loop [r :range [0 rows]] (matrix/place-element matrix [r (dec cols)] (element/new :brick)))

(defn scale [[x y]]
  (tuple (* x scale-factor) (* y scale-factor)))

(defn descale [[x y]]
  (tuple (math/floor (/ x scale-factor)) (math/floor (/ y scale-factor))))

(defn render [matrix]
  (let [{:rows rows :cols cols} matrix]
    (loop [r :range [0 rows] c :range [0 cols]]
      (let [element (matrix/get-element matrix [r c])]
        (if element
          (draw-rectangle-v
            (scale [r c])
            [scale-factor scale-factor]
            (matrix/color matrix [r c])))))))

(init-window screen-width screen-height "Sand")
(set-target-fps 60)
(show-cursor)

(begin-drawing)

(while (not (window-should-close))
  (clear-background [0 0 0])

  (let [[x y] (get-mouse-position)
        x (math/floor x)
        y (math/floor y)]
    (draw-circle ;[x y] 4 :light-gray)

    (if (mouse-button-down? :left)
      (matrix/place-element matrix (descale [x y]) (element/new :sand)))

    (if (mouse-button-down? :right)
      (matrix/place-element matrix (descale [x y]) (element/new :water))))

  (matrix/step matrix)
  (render matrix)

  (draw-fps 50 50)
  (end-drawing))

(close-window)
