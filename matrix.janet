(import ./element)

(defn new [num-rows num-cols]
  (let [rows (array/new num-rows)]
    (do
     (for r 0 num-rows
       (put rows r (array/new-filled num-cols nil)))
     @{:rows num-rows :cols num-cols :data rows})))
      
  
(defn place-element [matrix x y element]
  (let [data (matrix :data)
        row (get data x)
        new-col (put row y element)
        new-data (put data x new-col)]
    (put matrix :data new-data)))

(defn get-element [matrix x y]
  (let [row (get (matrix :data) x)]
    (in row y)))

(defn render-element [element x y draw-pixel]
  (if element (draw-pixel x y (element/color element))))

(defn render [matrix draw-pixel]
  (let [{:rows rows :cols cols} matrix]
    (for r 0 rows
      (for c 0 cols
        (let [element (get-element matrix r c)]
          (render-element element r c draw-pixel))))))
    

(def matrix (new 4 4))
(place-element matrix 0 0 1)
(place-element matrix 2 2 1)
(place-element matrix 3 3 1)
