module Wk1 where

-- What is the difference between a data and a type declaration?

-- What is the difference between a type and a data constructor? List the identifiers in the code which represent type names, and those which represent data constructor names.

-- Which phase of the compiler would be responsible for distinguishing type and data constructors?


-- mySum
mySum :: [Int] -> Int
mySum = undefined

-- myProduct
myProduct :: [Int] -> Int
myProduct = undefined

-- Find a generalisation myBinop that applies a given binary operator f with unit element z to a list of numbers. We will then be able to define myProduct and mySum using myBinop.

myBinop :: (Int -> Int -> Int) -> Int -> ([Int] -> Int)
myBinop = undefined

-- We just reinvented a wheel. The fold functions are general-purpose library functions that completely subsume myBinop. Try to implement mySum and myProduct using foldr instead of myBinop. (Hoogle!)
-- The linked library documentation references a lot of concepts that we don't assume familiarity with, so don't worry if you don't fully understand it. Perhaps start by looking at the examples.
