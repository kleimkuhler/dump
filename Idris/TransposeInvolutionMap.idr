module TransposeInvolutionMap

import Data.Vect

%default total
%hide Vect.transpose

cong2 : {f : t -> u -> v} -> (a = b) -> (c = d) -> f a c = f b d
cong2 Refl Refl = Refl

||| Compute the transpose of a matrix
|||
||| base (cols = 0): There are no columns of the matrix left to transpose, so []
||| inductive (cols = 1+): For each column of the matrix, prepend the head of that column onto the
|||                        transpose of the tail of the matrix
transpose : Vect m (Vect n elem) -> Vect n (Vect m elem)
transpose {n = Z} mat = []
transpose {n = (S k)} mat = map head mat :: transpose (map tail mat)

||| Transpose is its own inverse `f(f(x)) = x`
|||
||| base (empty matrix): `transpose [] = []`, therefore `transpose $ tranpose [] = []` and the
|||                      empty matrix is proven
||| inductive (non-empty matrix):
|||   If (a = b) and (b = c) then (a = c) by transitivity.
|||     (a = b): This is the recursive step for transpose_involution. In order to get back to `a`
|||              after recursing on `cols`, `cong` must be used to join `c` back onto the result.
|||     (b = c): This is the recursive step that proves:
|||                1) A column is the first row head of the transpose of the matrix
|||                2) The transpose of the rest is the transpose tail of the transpose of the rest
|||                   of the matrix
|||              1 and 2 above can be summarized to say:
|||                1) col = map head (transpose c :: cols)
|||                2) transpose cols = map tail (transpose c :: cols)
|||              Therefore, when {f} for `cong2` is `(::)` we know that:
|||                col :: tranpose $ transpose cols =
|||                map head (transpose c :: cols) :: tranpose $ map tail (transpose c :: cols)
|||     (a = c): Using the above inductive steps, it has been proved by transitivity that mat =
|||              tranpose $ tranpose mat
transpose_involution : (mat : Vect m (Vect n elem)) -> mat = transpose $ transpose mat
transpose_involution [] = Refl
transpose_involution (c :: cols) = trans (cong {f = (c ::)} (transpose_involution cols))
                                         (cong2 {f = (::)} (transpose_head c cols)
                                                           (cong {f = transpose} (transpose_tail c cols)))
  where
    ||| Inductive step: (b = c) step 1
    transpose_head : (c : Vect n elem) -> (cols : Vect m (Vect n elem)) ->
                     c = map Vect.head (transpose (c :: cols))
    transpose_head {n = Z} [] cols = Refl
    transpose_head {n = (S k)} (x :: c) cols = cong {f = (x ::)} $
                                                    transpose_head c (map tail cols)

    ||| Inductive step: (b = c) step 2
    transpose_tail : (c : Vect n elem) -> (cols : Vect m (Vect n elem)) ->
                     transpose cols = map Vect.tail (transpose (c :: cols))
    transpose_tail {n = Z} c cols = Refl
    transpose_tail {n = (S k)} (x :: c) cols = cong {f = ((map head cols) ::)} $
                                                    transpose_tail c (map tail cols)
