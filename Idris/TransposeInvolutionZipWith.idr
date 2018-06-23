-- WIP
module TransposeInvolutionZipWith

import Data.Vect

%default total

zipWith_replicate : (xs : Vect n elem) ->
                    zipWith (::) xs (map (Vect.replicate m) xs) = map (Vect.replicate (S m)) xs
zipWith_replicate [] = Refl
zipWith_replicate (x :: xs) = ?zipWith_replicate_rhs_2

replicate_nil : (xs : Vect n elem) -> Vect.replicate n Nil = map (Vect.replicate Z) xs
replicate_nil [] = Refl
replicate_nil (x :: xs) = ?replicate_nil_rhs_2

transpose_replicate : (xs : Vect n elem) ->
                      transpose (replicate n xs) = map (replicate n) xs
transpose_replicate [] = Refl
transpose_replicate (x :: xs) = ?transpose_replicate_rhs_2

transpose_involution : (mat : Vect m (Vect n elem)) -> mat = transpose $ transpose mat
transpose_involution [] = ?transpose_involution_rhs_1
transpose_involution (x :: xs) = ?transpose_involution_rhs_2
