module Wk7 where

sumInt :: Int -> Int
sumInt 0 = 0
sumInt n = n + sumInt (n-1)

sumInt' :: Int -> Int
sumInt' n = sum2 0 n
  where
    sum2 m 0 = m
    sum2 m n = sum2 (m+n) (n-1)

