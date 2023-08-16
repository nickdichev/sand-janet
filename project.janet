(declare-project
  :name "sand" # required
  :description "falling sand simulator" 

  :dependencies [
                 "git@github.com:janet-lang/jaylib.git"
                 "git@github.com:janet-lang/spork.git"
                 {:url "https://github.com/ianthehenry/judge.git" :tag "v2.6.1"}])
  
