module Wk10 where

-- ** Overloading ** --

class Compare a where
  cmp :: a -> a -> Bool

instance Compare Char where
  cmp :: Char -> Char -> Bool
  cmp x y = x <= y

instance Compare Int where
  cmp x y = x <= y

instance (Compare a) => Compare [a] where
  cmp xs ys = and (zipWith cmp xs ys)

group  :: (Compare a) => [a] -> [[a]]
group []     = []
group (x:xs) = let (ys, zs) = span (cmp x) xs
                in (x:ys) : group zs

group [1,2,3]

type CompareDict a = (a -> a -> Bool)

intCompareDict :: CompareDict Int
intCompareDict x y = x <= y

charCompareDict :: CompareDict Char
charCompareDict x y = x <= y



-- listCompareDict charCompareDict :: CompareDict [Char]

listCompareDict :: CompareDict a -> CompareDict [a]
listCompareDict cmp xs ys = and (zipWith cmp xs ys)

group  :: CompareDict a -> [a] -> [[a]]
group cmp []     =  []
group cmp (x:xs) = let (ys, zs) = span (cmp x) xs
                    in (x:ys) : group cmp zs

group (listCompareDict intCompareDict) [1,2,3]

-- ** Coercions and subtyping ** --

-- c. Define a data type Square and a data type Rectangle in Haskell. Then define a coercion function from elements of the subclass to elements of the superclass.
data Square = Square Int
data Rectangle = Rectangle Int Int

coerce :: Square -> Rectangle
coerce (Square x) = Rectangle x x


-- Rectangle -> Rectangle is a supertype of Rectangle -> Square
coerce1 :: (Rectangle -> Square) -> (Rectangle -> Rectangle) 
-- coerce1 f x = coerce (f x)
-- coerce1 f = coerce . f
coerce1 f = \x -> coerce (f x)


-- Rectangle -> Rectangle is a subtype of Square -> Rectangle
coerce2 :: (Rectangle -> Rectangle) -> (Square -> Rectangle)
coerce2 f = f . coerce

data Sum a b = InL a | InR b
-- data Sum = InL Rectangle | InR Rectangle
data Sum2 = InL Square | InR Rectangle

data Product = Product Rectangle Rectangle
data Product2 = Product Square Rectangle

data En a = En (a -> a)
En Rectangle
En Square


data Arg a = Arg (a -> Int)
foo :: Arg Rectangle

bar :: Arg Square


-- d. Show that the ordering you have given in the previous question is correct by defining coercion functions for each pair of types in a subtyping relationship in part (b).





lock l; 

var x1; 
take(l);
  x1 := x + 1; 
  x := x1; 
release(l); 
take(l); 
  x1 := x - 1; 
  x := x1;
release(l); 

var x2; 
take(l); 
  x2 := x * 2; 
  x := x2;
release(l);





bool l; 

var x1; 
while (l) {}
  l = true;
  x1 := x + 1; 
  x := x1; 
l = false;
while (l) {}
  l = true;
  x1 := x - 1; 
  x := x1;
l = false;

var x2; 
while (l) {}
  l = true; 
  x2 := x * 2; 
  x := x2;
l = false;