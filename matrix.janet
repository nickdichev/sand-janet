(defn new [num-rows num-cols]
  (let [rows (array/new num-rows)]
    (do
     (for r 0 num-rows
       (put rows r (array/new-filled num-cols nil)))
     @{:num-rows num-rows :num-cols num-cols :data rows})))
      
  
(defn place-element [matrix x y element]
  (let [row (get (matrix :data) x)
        new-col (put row y element)]
    (put matrix x new-col)))

(defn get-element [matrix x y]
  (let [row (get (matrix :data) x)]
    (in row y)))

(use jaylib)
(import ./element)

(defn render-element [element x y]
  (if element (draw-pixel x y (element/color element))))

(defn render [matrix]
  (clear-background [0 0 0])
  (let [{:num-rows num-rows :num-cols num-cols} matrix]
    (for r 0 num-rows
      (for c 0 num-cols
        (let [element (get-element matrix r c)]
          (render-element element r c))))))
    

(def matrix (new 4 4))
(place-element matrix 0 0 1)
(place-element matrix 2 2 1)
(place-element matrix 3 3 1)
