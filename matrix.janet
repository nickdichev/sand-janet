(defn new [num-rows num-cols]
  (let [rows (array/new num-rows)]
    (do
     (for r 0 num-rows
       (put rows r (array/new-filled num-cols nil)))
     rows)))
      
  
(defn place-element [matrix x y element]
  (let [row (get matrix x)
        new-col (put row y element)]
    (put matrix x new-col)))
    

(def matrix (new 4 4))
(place-element matrix 0 0 1)
(place-element matrix 2 2 1)
(place-element matrix 3 3 1)
