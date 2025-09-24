module Wk5 where

data Type =
  Bool
  | Int
  | FunTy Type Type -- Type -> Type
    deriving (Show,Eq)

data Expr =
  Num Int
  | Lit Bool
  | If Expr Expr Expr
  | Apply Expr Expr
  | Plus Expr Expr
  | Eq Expr Expr
  | Recfun Type Type (Expr -> Expr -> Expr)
  | Var String -- only used for pretty-printing. Ignore.

-- TODO: Implement a Value type and an evaluator function for this language.
data Value = BoolV Bool | IntV Int | FuncV (Expr -> Expr -> Expr) 

equals :: Value -> Value -> Bool
equals (BoolV b1) (BoolV b2) = b1 == b2
equals (IntV b1) (IntV b2) = b1 == b2
equals _ _ = False

uneval :: Value -> Expr
uneval (BoolV b) = Lit b
uneval (IntV n) = Num n
uneval (FuncV f) = Recfun Bool Bool f

eval :: Expr -> Value
eval (Num n) = IntV n
eval (Lit b) = BoolV b
eval (If a b c) = 
  case eval a of 
    (BoolV True) -> eval b
    (BoolV False) -> eval c
    _ -> error "If statement condition not a boolean"
eval (Apply f x) = 
  let (FuncV f') = eval f 
      x' = eval x
  in eval (f' (uneval (FuncV f')) (uneval x'))
eval (Plus x y) =
  let (IntV x') = eval x
      (IntV y') = eval y in
        IntV (x' + y')
eval (Eq x y) =
  let x' = eval x
      y' = eval y in
        BoolV (equals x' y')
eval (Recfun _ _ f) = FuncV f
eval (Var x) = error "should never happen"
