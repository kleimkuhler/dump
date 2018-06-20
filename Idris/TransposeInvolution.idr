module TransposeInvolution

%default total
%hide zipWith
%hide transpose

data Vect : (len : Nat) -> (elem : Type) -> Type where
  Nil : Vect 0 elem
  (::) : (x : elem) -> (xs : Vect len elem) -> Vect (S len) elem

zipWith : (f : a -> b -> c) -> (xs : Vect n a) -> (ys : Vect n b) -> Vect n c
zipWith f [] [] = []
zipWith f (x :: xs) (y :: ys) = f x y :: zipWith f xs ys

replicate : (len : Nat) -> (x : elem) -> Vect len elem
replicate Z x = []
replicate (S k) x = x :: replicate k x

transpose : Vect m (Vect n elem) -> Vect n (Vect m elem)
transpose [] = replicate _ []
transpose (x :: xs) = let xsTrans = transpose xs in
                         zipWith (::) x xsTrans

lem1 : [] = transpose (replicate n [])
lem1 {n = Z} = Refl
lem1 {n = (S k)} = ?lem1_rhs_2

transpose_involution : (mat : Vect m (Vect n elem)) -> mat = transpose $ transpose mat
transpose_involution [] = lem1
transpose_involution (x :: xs) = ?transpose_involution_cons
