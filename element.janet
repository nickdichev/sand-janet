(defn new [element]
  {:type element})
  
(defn color [element]
  (case (element :type)
    :water :blue
    :sand :yellow
    :brick :dark-gray))

(defn water-translation []
  (tuple [0 1] [-1 0] [1 0] [0 0]))

(defn sand-translation []
  (tuple [0 1] [-1 1] [1 1] [0 0]))

(defn stationary-translation []
  (tuple [0 0]))

(defn step-translations [element]
  (case (element :type)
    :water (water-translation)
    :sand (sand-translation)
    :brick (stationary-translation)))
