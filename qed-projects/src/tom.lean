import number_theory.legendre_symbol.quadratic_reciprocity
import data.nat.prime
import tactic
import data.zmod.basic
import data.fintype.card



-- Zeige die bekannten Rechenregeln zu Legendre Symbolen

-- Zeige : Für alle ganze Zahlen a,b und alle Primzahlen p gilt  a = b mod p → legendre(a p)= legendre(b p)
example (a b : ℕ) (p : ℕ) (prime_p : fact (nat.prime p)):
  a ≡ b [MOD p] → legendre_sym p a = legendre_sym p b  :=
begin
  intro h,
  unfold legendre_sym, -- wird benötigt damit wir a,b in zmod haben
  rw [← zmod.eq_iff_modeq_nat] at h,
  simp,
  rw[h],

  --rw[zmod.eq_iff_modeq_nat],

  -- eq_iff_modeq
end
example  (p : ℕ) (a b : zmod p) (prime_p : fact (nat.prime p)):
  a = b → legendre_sym p a = legendre_sym p b  :=
begin
  intro h,
  rw[h],
end
-- Zeige legendre(a p) * legendre(b p) = legendre (ab p)

example (a b : ℤ) (p: ℕ) (prime_p : fact (nat.prime p)) :
  legendre_sym p a * legendre_sym p b = legendre_sym p (a*b) :=
begin
  unfold legendre_sym,
  simp,
  rw[quadratic_char_fun_mul],
end

open_locale big_operators

-- wenn das legendre symbol 1 ist, existiert ein x aus zmod p mit x^2 = a
lemma is_qr (p : ℕ) [h : (p > 2)] [prime_p : fact (nat.prime p)] (a : zmod p) [ t : a ≠0]   :
  legendre_sym p a = 1 ↔ ∃ x : zmod p, x^2 = a :=
begin
  constructor,
  intro h₁,
  rw[legendre_sym.eq_one_iff] at h₁,
  unfold is_square at h₁,
  obtain ⟨hj,hr⟩ := h₁,
  use hj,
  simp at hr,
  rw[hr],
  ring,
  simp,
  assumption,
  intro hr,
  obtain ⟨hr,hj⟩ := hr,
  rw[legendre_sym.eq_one_iff],
  simp,
  unfold is_square,
  use hr,
  rw[←hj],
  ring,
  simp,
  assumption,
end

variables (p : ℕ) [prime_p : fact (nat.prime p)]
#check zmod.euler_criterion p

-- example (a : zmod p) : a ^ 2 = - a ^ 2 := by sorry

-- example (h: p ≠ 2) : nat.card {a : zmod p | is_square a} = (p - 1) / 2 :=
-- begin
--   suffices hs : nat.card {a : zmod p | is_square a} = (p - 1) / 2,
-- end

example (p : ℕ) (p ≠ 2) [prime_p : fact (nat.prime p)] (a : zmod p) (h : a ≠ 0) (x : ℕ) :
  ¬ is_square (a ^ (2*x + 1)) :=
begin
  have ha : a ^ (2*x + 1) ≠ 0,
  { -- einfach, Helfer.
    sorry },
  rw [zmod.euler_criterion p ha],
  suffices hb : (a ^ x) ^ (p - 1) * a ^ (p/2) ≠ 1,
  { -- umformung, wobei `p/2` floor division ist, und deshalb `p ≠ 2` bräuchte.
    sorry },
  sorry,
end

example (p : ℕ) (p ≠ 2) [prime_p : fact (nat.prime p)] (a : zmod p) (h : a ≠ 0) (x : ℕ) :
  is_square (a ^ (2*x)) :=
begin
  have ha : a ^ (2*x) ≠ 0,
  { -- einfach, Helfer.
    sorry },
  rw [zmod.euler_criterion p ha],
  suffices hb : (a ^ x) ^ (p - 1) = 1,
  { -- umformung, wobei `p/2` floor division ist, und deshalb `p ≠ 2` bräuchte.
    sorry },
  sorry, -- `a ^ (p-1) = 1 (mod p)`
end

-- 1. is_square a ↔ a^((p-1/2)) ≡ 1
-- 2. write `(zmod p)ˣ` cyclic as `a^n`s
-- 3. note that `a^(2n)^((p-1/2)) = (a^n)^(p-1) ≡ 1`
-- 4. note that `a^(2n+1)^(p-1/2) = a^n^(p-1) * a^((p-1)/2) = a^((p-1)/2) ≠ 1`

lemma anz_qr (p : ℕ) (h : (p > 2)) (prime_p : fact (nat.prime p)) (a : zmod p)  :
   (nat.card {a : zmod p | ∃ x : zmod p, x^2 = a} = (p-1)/2) ∧ (nat.card {a : zmod p | ¬∃ x : zmod p, x^2 = a}) = (p-1)/2:=

  --unter den zahlen 1,...,p-1 sind genau (p-1)/2 quadratische Reste mod p (und (p-1)/2 quadratische nichtreste)
begin
  sorry
end

-- Zeige ∑1 bis p-1 legendre_sym p a = 0
example (a : ℕ) (p : ℕ) (prime_p : fact (nat.prime p)) (h: p>2) :
   (∑ a in finset.range (p-2), legendre_sym p (a+1) )= 0 := -- von 1 bis p-1 wie?
begin
  -- versuchen lemma anz_qr anzuwenden
  have g : (∀ b : ℕ, b ∈ finset.range (p-2) → legendre_sym p (b+1) = 1 ∨ legendre_sym p (b+1) = -1),
  {
    sorry
    --apply quadratic_char_dichotomy,
    --simp,
  },


  --apply [quadratic_char_dichotomy t],
end
#exit
-- teil des qrg's
example (p q : ℕ) (prime_p : fact (nat.prime p)) (prime_q : fact (nat.prime q)) (h:(p ≡ 3 [ZMOD 4]) ∧ (q ≡ 3 [ZMOD 4])) (g : p ≠ q) :
  legendre_sym p q * legendre_sym q p = -1 :=
begin
  obtain ⟨h₁,h₂⟩ := h,
  unfold legendre_sym,
  simp,
  rw[int.modeq_iff_add_fac] at *,
  obtain ⟨x,h₁x⟩ := h₁,
  obtain ⟨y,h₂y⟩ := h₂,
  rw[lol] at h₁x,
  rw[h₂y] at h₁x,
  simp,
end
-- (3:fin 5) + (6:fin 5)
-- (h: a = b [MOD n])
-- (a b : fin n) (h : a = b)
