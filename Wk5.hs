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

