return :: a -> [a]
return x = [x]

(>>=) :: [a] -> (a -> [b]) -> [b]
(>>=) as f = concat $ map f as


data Maybe a = Just a | Nothing
return :: a -> Maybe a
return x = Just x

(>>=) :: (Maybe a) -> (a -> Maybe b) -> Maybe b
(>>=) Nothing _ = Nothing
(>>=) (Just x) f = f x

lookupStudentByName :: String -> Maybe String
getStudentsTeacher :: String -> Maybe String

lookupStudentTeacher :: String -> Maybe String
lookupStudentTeacher name = lookupStudentByName name >>= getStudentsTeacher

lookupStudentTeacher :: String -> Maybe String
lookupStudentTeacher name = do
  id <- lookupStudentByName name
  getStudentsTeacher id

module Wk9 where

{-
  1    2    3    4    5
  🪦   🪦   🪦    🪦   🪦

A mole is disturbing a row of five graves. The mole is always
underneath one of the graves.

1. Each day, we may attempt to catch the mole by
   digging up a grave. If we found the mole, we win;
   otherwise, we put the grave back in order and go to sleep.
2. Each night, the mole must move from its current position to an
   adjacent grave.

Find a sequence of digs that is guaranteed to find the mole.
-}


-- Write a function move_mole : Int -> [Int] such that, if the mole is at grave n initially, move_mole n is the list of graves the mole might be at after its nightly move.
move_mole :: Int -> [Int]
move_mole 1 = [2]
move_mole 5 = [4]
move_mole x = [x-1, x+1]

-- Write a function kill_mole : Int -> Int -> [Int]. If we dig at grave d, and the mole is at position m, kill_mole d m should return the empty list if we found the mole, and [m] if the mole is still at loose.
kill_mole :: Int -> Int -> [Int]
kill_mole d m = if d == m then [] else [m]

-- Let's define the list monad! Write Haskell functions that inhabit the following type signatures, and think about whether they satisfy the monad laws:
myReturn :: a -> [a]
myReturn x = [x]

myBind   :: [a] -> (a -> [b]) -> [b]
myBind as f = concat $ map f as


-- Here's an implementation of a move function for following a sequence of moves. If the mole is initially at position m, and we perform the sequence of digs xs, then move xs m is the list of final positions the mole could be at. (The final result may contain duplicates but we don't care.) Can you use the list monad (either the one you just defined, or the built-in one in Haskell) to simplify it?

move :: [Int] -> Int -> [Int]
move [] m = [m]
move (x:xs) m =
  let ys = kill_mole x m
      zs = concat (map move_mole ys)
  in
    concat (map (move xs) zs)

move' :: [Int] -> Int -> [Int]
move' (x:xs) m = kill_mode x m >>= move_mole >>= (move xs)

move'' :: [Int] -> Int -> [Int]
move'' (x:xs) m = do
  afterKillPos <- kill_mode x m
  afterMovePos <- move_mole afterKillPos
  move xs afterMovePos
move'' [] m = return m

-- Using do notation and move, write a function play : [Int] -> [Int] that returns the possible final locations of the mole after we've performed a sequence of moves, regardless of the mole's initial position.
play :: [Int] -> [Int]
play xs = concat $ map (move xs) [1..5]

play' :: [Int] -> [Int]
play' xs = do
  startPos <- [1..5]
  move xs startPos
