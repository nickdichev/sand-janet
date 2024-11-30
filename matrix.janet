(import ./element)

(defn- to1D [matrix [x y]]
  (let [cols (matrix :cols)]
    (+ (* x cols) y)))

(defn- to2d [matrix i]
  (let [cols (matrix :cols)
        x (/ i cols)
        y (mod i cols)]
    [(math/floor x) y]))

(defn new [num-rows num-cols]
     @{:rows num-rows
       :cols num-cols
       :elements (array/new-filled (* num-rows num-cols))})

(defn- place [matrix [x y] item]
  (let [elements (matrix :elements)
        i (to1D matrix [x y])
        new-elements (put elements i item)]
    (put matrix :elements new-elements)))

(defn place-element [matrix [x y] element]
  (place matrix [x y] element))

(defn clear-element [matrix [x y]]
  (place matrix [x y] nil))

(defn get-element [matrix [x y]]
  (let [i (to1D matrix [x y])
        elements (matrix :elements)]
    (in elements i)))

(defn empty? [matrix [x y]]
  (nil? (get-element matrix [x y])))

(defn color [matrix [x y]]
  (let [element (get-element matrix [x y])]
    (if (nil? element) :black (element :color))))

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
            step-translations (element :translation)
            [x y] (find-valid-translation matrix step-translations [r c])]
        (if (should-redraw? [x y] [r c])
          (move-element matrix element [r c] [x y]))))))
    

# re-write find-valid-translation to look at the current (r,c) and all surrounding neighbors. this will allow sand to fall down in water
         
(use judge)

(test (to1D (new 4 4) [0 0]) 0)
(test (to1D (new 4 4) [1 3]) 7)
(test (to1D (new 4 4) [3 3]) 15)

(test (to2d (new 4 4) 0) [0 0])
(test (to2d (new 4 4) 7) [1 3])
(test (to2d (new 4 4) 15) [3 3])

