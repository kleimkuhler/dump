module TransposeInvolution

%default total

data Vect : (len : Nat) -> (elem : Type) -> Type where
  Nil : Vect 0 elem
  (::) : (x : elem) -> (xs : Vect len elem) -> Vect (S len) elem

zipWith : (f : a -> b -> c) -> (xs : Vect n a) -> (ys : Vect n b) -> Vect n c
zipWith f [] [] = []
zipWith f (x :: xs) (y :: ys) = f x y :: zipWith f xs ys

replicate : (len : Nat) -> (x : elem) -> Vect len elem
replicate Z x = []
replicate (S k) x = x :: replicate k x

transpose : Vect m (Vect n a) -> Vect n (Vect m a)
transpose [] = replicate _ []
transpose (x :: xs) = let xsTrans = transpose xs in
                         zipWith (::) x xsTrans

transpose_involution : (mat : Vect m (Vect n a)) -> mat = transpose $ transpose mat
transpose_involution {n = Z} [] = Refl
transpose_involution {n = (S k)} [] = ?transpose_involution_rhs_4
transpose_involution (x :: xs) = ?transpose_involution_rhs_2
