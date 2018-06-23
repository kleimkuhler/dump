-- WIP
module TransposeInvolutionMap

import Data.Vect

%default total
%hide Vect.transpose

||| Compute the transpose of a matrix
|||
||| base (rows = 0): There are no columns of the matrix left to transpose, so return []
||| inductive (rows = 1+): For each row of the matrix, prepend the head of that row onto the
|||                        transpose of the tail of that row
transpose : Vect m (Vect n elem) -> Vect n (Vect m elem)
transpose {n = Z} mat = []
transpose {n = (S k)} mat = map head mat :: transpose (map tail mat)

||| Transpose is its own inverse `f(f(x)) = x`
|||
||| base (empty matrix): `transpose [] = []`, therefore `transpose $ tranpose [] = []` and the
|||                      empty matrix is proven
||| inductive (non-empty matrix):
transpose_involution : (mat : Vect m (Vect n elem)) -> mat = transpose $ transpose mat
transpose_involution [] = Refl
transpose_involution (x :: xs) = ?transpose_involution_rhs_2
