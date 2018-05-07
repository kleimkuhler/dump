module Proofs

import Data.Vect

plus' : Nat -> Nat -> Nat
plus' Z j = j
plus' (S k) j = S (plus' k j)

-- Function capturing `Nat` inductive definitions
nat_induction : (P : Nat -> Type) ->             -- property to show
                (P Z) ->                         -- base case
                ((k : Nat) -> P k -> P (S k)) -> -- inductive step
                (x : Nat) ->                     -- show for all x
                P x                
nat_induction P p_Z p_S Z = p_Z
nat_induction P p_Z p_S (S k) = p_S k (nat_induction P p_Z p_S k)

plus_ind : Nat -> Nat -> Nat
plus_ind n m = nat_induction (\x => Nat)
                             m                      -- base case, plus_Ind Z m
                             (\k, k_rec => S k_rec) -- inductive step, plus_ind (S k) m
                             n

plus_commutes_Z : m = plus m 0
plus_commutes_Z {m = Z} = Refl
plus_commutes_Z {m = (S k)} = let ind = plus_commutes_Z {m=k} in
                                  rewrite ind in Refl

plus_commutes_S : (k : Nat) -> (m : Nat) -> S (plus m k) = plus m (S k)
plus_commutes_S k Z = Refl
plus_commutes_S k (S j) = let ind = plus_commutes_S k j in
                              rewrite ind in Refl

plus_commutes : (n : Nat) -> (m : Nat) -> n + m = m + n
plus_commutes Z m = plus_commutes_Z
plus_commutes (S k) m = let ind = plus_commutes k m in
                            rewrite ind in plus_commutes_S k m
