(ns test-check.faker-test
  (:require
   [clojure.string :as str]
   [clojure.test :refer :all]
   [faker.company :as fc]
   [faker.lorem :as fx]
   [faker.name :as fn]))

(def tests-quantity 100)

(deftest faker-names-are-all-strings
  (is (every? string? (take tests-quantity (fn/names)))))

(deftest faker-names-are-more-than-one-word
  (is (every? #(<= 2 %) (map count (map #(str/split % #" ") (take tests-quantity (fn/names)))))))

(deftest faker-companies-are-all-strings
  (is (every? string? (take tests-quantity (fc/names)))))

(comment
  (take 3 (fn/names))
  (take 2 (fx/paragraphs 4))
  (take 10 (fx/words))
  (take 3 (fx/sentences 4)))
