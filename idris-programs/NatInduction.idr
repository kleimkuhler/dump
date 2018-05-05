module NatInduction

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
