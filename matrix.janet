(import ./element)

(defn new-matrix [num-rows num-cols]
  (let [rows (array/new num-rows)]
     (do
       (loop [r :range [0 num-rows]]
         (put rows r (array/new-filled num-cols nil))))
     rows))

(defn new [num-rows num-cols]
     @{:rows num-rows
       :cols num-cols
       :elements (new-matrix num-rows num-cols)})

(defn place [matrix-data [x y] item]
  (let [row (get matrix-data x)
        new-col (put row y item)]
    (put matrix-data x new-col)))

(defn place-element [matrix [x y] element]
  (let [elements (matrix :elements)
        new-elements (place elements [x y] element)]
    (put matrix :elements new-elements)))

(defn clear-element [matrix [x y]]
  (place-element matrix [x y] nil))

(defn get-element [matrix [x y]]
  (let [row (get (matrix :elements) x)]
    (in row y)))

(defn empty? [matrix [x y]]
  (nil? (get-element matrix [x y])))

(defn color [matrix [x y]]
  (let [element (get-element matrix [x y])]
    (if (nil? element) :black (element/color element))))

(defn translate-coord [[x y] [dx dy]]
  (tuple (+ x dx) (+ y dy)))

(defn find-valid-translation [matrix step-translations [r c]]
  (->> step-translations
       (map |(translate-coord [r c] $))
       (filter |(or (empty? matrix $) (= [r c] $)))
       (first)))

(defn should-redraw? [[x y] [r c]]
  (or (not= x r) (not= y c)))

(defn move-element [matrix element [x1 y1] [x2 y2]]
  (place-element matrix [x2 y2] element)
  (clear-element matrix [x1 y1]))
       
(defn step [matrix]
  (let [{:rows rows :cols cols} matrix
        elements (matrix :elements)]
    (loop [r :down-to [(dec rows) 0]
           c :down-to [(dec cols) 0]
           :when (not (empty? matrix [r c]))]
      (let [element (get-element matrix [r c])
            step-translations (element/step-translations element)
            [x y] (find-valid-translation matrix step-translations [r c])]
        (if (should-redraw? [x y] [r c])
          (move-element matrix element [r c] [x y]))))))
    
         
          
                                                 
