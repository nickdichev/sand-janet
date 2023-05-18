(import ./element)

(defn new [num-rows num-cols]
  (let [rows (array/new num-rows)]
    (do
     (loop [r :range [0 num-rows]]
       (put rows r (array/new-filled num-cols nil)))
     @{:rows num-rows :cols num-cols :data rows})))
      
(defn place-element [matrix x y element]
  (let [data (matrix :data)
        row (get data x)
        new-col (put row y element)
        new-data (put data x new-col)]
    (put matrix :data new-data)))

(defn clear-element [matrix x y]
  (place-element matrix x y nil))

(defn get-element [matrix x y]
  (let [row (get (matrix :data) x)]
    (in row y)))

(defn empty? [matrix x y]
  (nil? (get-element matrix x y)))

(defn render-element [element x y draw-pixel]
  (if element (draw-pixel x y (element/color element))))

(defn render [matrix draw-pixel]
  (let [{:rows rows :cols cols} matrix]
    (loop [r :range [0 rows] c :range [0 cols]]
      (let [element (get-element matrix r c)]
        (render-element element r c draw-pixel)))))

(defn translate-coord [x y [dx dy]]
  (tuple (+ x dx) (+ y dy)))

(defn find-valid-translation [translations r c]
  (let [translations (map |(translate-coord r c $) translations)]))

(defn step [matrix]
  (let [{:rows rows :cols cols} matrix
        data (matrix :data)]
    (loop [r :down-to [(dec rows) 0]
           c :down-to [(dec cols) 0]
           :when (not (empty? matrix r c))]
      (let [element (get-element matrix r c)
            translations (element/step-translations element)
            [[new-x new-y]] (find-valid-translation translations r c)]
        (place-element matrix new-x new-y element)
        (clear-element matrix r c)))))
