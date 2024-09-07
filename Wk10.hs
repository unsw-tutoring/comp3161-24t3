module Wk10 where

-- ** Overloading ** --

class Compare a where
  cmp :: a -> a -> Bool

instance Compare Int where
  cmp x y = x <= y

instance (Compare a) => Compare [a] where
  cmp xs ys = and (zipWith cmp xs ys)

group  :: (Compare a) => [a] -> [[a]]
group []     = []
group (x:xs) = let (ys, zs) = span (cmp x) xs
                in (x:ys) : group zs


-- ** Coercions and subtyping ** --

-- c. Define a data type Square and a data type Rectangle in Haskell. Then define a coercion function from elements of the subclass to elements of the superclass.


-- d. Show that the ordering you have given in the previous question is correct by defining coercion functions for each pair of types in a subtyping relationship in part (b).

