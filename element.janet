(defn new [element]
  {:type element})
  
(defn color [element]
  (case (element :type)
    :water :blue
    :sand :yellow
    :brick :dark-gray))
