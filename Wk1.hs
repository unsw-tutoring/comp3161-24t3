module Wk1 where

-- What is the difference between a data and a type declaration?
data MyType = Cons1 Int | Cons2 Char | Cons3 Int Int
    deriving Show
-- MyType is a type
-- Cons1 is a constructor (a function of type Int -> MyType)
-- Cons2 is a constructor (a function of type Char -> MyType)
-- Cons3 is a constructor (a function of type Int -> Int -> MyType)


data MyType2 = Cons4 | MyType2 Int
-- MyType2 is both a type and a constructor (of type Int -> MyType2)
-- Cons4 is a constructor of type MyType2

-- the 'type' keyword allows us to define a type alias 
-- (i.e., another name for an already existing type)
type MyIntList = [Int]

type MyTuple = (Int, Char, Int, Bool)


addOne :: Int -> Int
-- addOne(x) = x + 1
addOne x = x + 1

-- addOne 1 
-- = 1 + 1
-- = 2


myAddBad :: (Int, Int) -> Int
myAddBad (x, y) = x + y


-- myAdd :: Int -> (Int -> Int)
myAdd :: Int -> Int -> Int
myAdd x y = x + y


divides :: Int -> Int -> Int
divides _ 0 = error "Cannot divide by zero"
divides x y = div x y


-- partial application
addThree :: Int -> Int
-- addThree x = myAdd 3 x
addThree = myAdd 3

-- Lists:
--  []
--  (x:xs)

-- What is the difference between a type and a data constructor? List the identifiers in the code which represent type names, and those which represent data constructor names.
data MyVeryCoolType = Constructor1 Int | Constructor2 Char Int
    deriving Show

data DaysOfTheWeek = Monday | Tuesday | Wednesday

data Present a = Present a | Present2 a a 
    deriving Show

-- Which phase of the compiler would be responsible for distinguishing type and data constructors?
    -- lexer
    -- parser: YES
    -- semantic analyser
    -- optimiser
    -- code generation


-- mySum
mySum :: [Int] -> Int
mySum []     = 0
mySum (x:xs) = x + mySum xs

-- mySum [1,2,3] = mySum (1:[2,3])
--               = 1 + mySum [2,3] = 1 + mySum (2:[3])
--               = 1 + 2 + mySum [3]
--               = 1 + 2 + 3 + mySum []
--               = 1 + 2 + 3 + 0
--               = 6

-- myProduct
myProduct :: [Int] -> Int
myProduct []     = 1
myProduct (x:xs) = x * myProduct xs

-- Find a generalisation myBinop that applies a given binary operator f with unit element z to a list of numbers. We will then be able to define myProduct and mySum using myBinop.

myBinop :: (Int -> Int -> Int) -> Int -> ([Int] -> Int)
myBinop _ z []      = z
myBinop op z (x:xs) = op x (myBinop op z xs)


mySum2 :: [Int] -> Int
-- mySum2 xs = myBinop (+) 0 xs
mySum2 = myBinop (+) 0


myProduct2 :: [Int] -> Int
myProduct2 = myBinop (*) 1


-- We just reinvented a wheel. The fold functions are general-purpose library functions that completely subsume myBinop. Try to implement mySum and myProduct using foldr instead of myBinop. (Hoogle!)
-- The linked library documentation references a lot of concepts that we don't assume familiarity with, so don't worry if you don't fully understand it. Perhaps start by looking at the examples.

-- foldr :: (a -> b -> b) -> b -> [a] -> b
-- a = Int
-- b = Int
-- foldr :: (Int -> Int -> Int) -> Int -> [Int] -> Int

myBinOp2:: (Int -> Int -> Int) -> Int -> ([Int] -> Int)
myBinOp2 = foldr
