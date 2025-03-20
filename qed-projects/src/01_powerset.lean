import data.set.finite

variables {U : Type*}

open set
variable M : set U

example (h : M.finite) : (𝒫 M).finite :=
begin
  cases h.exists_finset_coe with M_fin h_M_fin,

  -- This step is somewhat akward, one needs to turn `coe : finset → set` into an `embedding`
  -- To apply it to each subset of `M_fin.powerset`.
  set P := finset.map ⟨coe, finset.coe_injective⟩ M_fin.powerset,

  apply finite.of_finset P,

  intro S,
  split,
  { intro hS,
    simp at ⊢ hS,
    obtain ⟨S_fin, h_S_fin, h_S_fin'⟩ := hS,
    rw [←h_S_fin', ←h_M_fin],
    simp,
    exact h_S_fin,
  },
  { intro hS,
    simp at ⊢ hS,
    lift S to finset U using finite.subset h hS,
    use S,
    rw ←h_M_fin at hS,
    constructor,
    exact finset.coe_subset.mp hS,
    refl,
  }
end

/-
Alternativ könnte man `variable M : finset U` definieren. `finset` is eine
endiche Menge und per Definition ist dann `M.powerset` wieder ein `finset`.

Ein `finset` kann mit `(M : set U)` oder `↑M` in ein `set` coerced werden.
-/
