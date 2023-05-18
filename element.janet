(defn new [element]
  {:type element})
  
(defn color [element]
  (case (element :type)
    :water :blue
    :sand :yellow
    :brick :dark-gray))

(defn water-translation []
  [[0 1] [-1 0] [1 0] [0 0]])

(defn sand-translation []
  [[0 1] [-1 1] [1 1] [0 0]])

(defn stationary-translation []
  [[0 0]])

(defn step-translations [element]
  (case (element :type)
    :water (water-translation)
    :sand (sand-translation)
    :brick (stationary-translation)))
