(ns test-check.core-test
  (:require [test-check.core :as sut]
            [clojure.test :as t]))

(def a-def 42)

(defn a-defn
  "test definition"
  [a b c]
  c a b)
