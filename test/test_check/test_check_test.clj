(ns test-check.test-check-test
   (:require [clojure.test.check.clojure-test :refer [defspec]]
             [clojure.test.check.generators :as gen]
             [clojure.test.check.properties :as prop]))

(def tests-quantity 100)

(defspec first-element-is-min-after-sorting
  tests-quantity ;; the number of iterations for test.check to test
  (prop/for-all [v (gen/not-empty (gen/vector gen/small-integer))]
    (= (apply min v)
       (first (sort v)))))

(defspec last-element-is-max-after-sorting
  tests-quantity ;; the number of iterations for test.check to test
  (prop/for-all [v (gen/not-empty (gen/vector gen/small-integer))]
    (= (apply max v)
       (last (sort v)))))

(defspec number-of-elements-is-same-after-sorting
  tests-quantity ;; the number of iterations for test.check to test
  (prop/for-all [v (gen/not-empty (gen/vector gen/small-integer))]
    (= (count v)
       (count (sort v)))))

(defn- no-42s? [v]
   (zero? (count (filter #(= 42 %) (sort v)))))

#_(defspec number-42-is-filtered-after-sorting)
  tests-quantity ;; the number of iterations for test.check to test
  (prop/for-all [v (gen/not-empty (gen/vector gen/small-integer))]
    (no-42s? v))

