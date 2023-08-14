(defn sand []
  {:type :sand
   :matter :solid
   :color :yellow
   :translation [[0 1] [-1 1] [1 1] [0 0]]})

(defn brick []
  {:type :brick
   :matter :solid
   :color :dark-gray
   :translation [[0 0]]})

(defn water []
  {:type :water
   :matter :liquid
   :color :blue
   :translation [[0 1] [-1 0] [1 0] [0 0]]})
