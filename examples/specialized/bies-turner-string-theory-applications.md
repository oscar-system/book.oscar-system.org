---
layout: page
title: F-Theory Applications of OSCAR
---

## Authors: Martin Bies and Andrew P. Turner

```julia
julia> B3 = projective_space(NormalToricVariety, 3)
Normal toric variety

julia> cox_ring(B3)
Multivariate polynomial ring in 4 variables over QQ graded by
  x1 -> [1]
  x2 -> [1]
  x3 -> [1]
  x4 -> [1]

julia> Kbar = anticanonical_bundle(B3)
Toric line bundle on a normal toric variety

julia> W = toric_line_bundle(torusinvariant_prime_divisors(B3)[1])
Toric line bundle on a normal toric variety

julia> x1 = basis_of_global_sections(W)[4]
x1

julia> a10 = sum([rand(Int) * b for b in basis_of_global_sections(Kbar)]);

julia> a21 = sum([rand(Int) * b for b in basis_of_global_sections(Kbar^2 * W^(-1))]);

julia> a32 = sum([rand(Int) * b for b in basis_of_global_sections(Kbar^3 * W^(-2))]);

julia> a43 = sum([rand(Int) * b for b in basis_of_global_sections(Kbar^4 * W^(-3))]);

julia> a65 = 0;

julia> t = global_tate_model(B3, [a10, a21 * x1, a32 * x1^2, a43 * x1^3, a65 * x1^5], completeness_check = false)
Global Tate model over a concrete base

julia> sing = singular_loci(t);

julia> length(sing)
2

julia> singular_loci(t)[2]
(Ideal (x1), (0, 0, 5), "Split I_5")

julia> singular_loci(t)[1][2:3]
((0, 0, 1), "I_1")

julia> amb = ambient_space(t)
Normal toric variety

julia> cox_ring(amb)
Multivariate polynomial ring in 7 variables over QQ graded by
  x1 -> [1 0]
  x2 -> [1 0]
  x3 -> [1 0]
  x4 -> [1 0]
  x -> [8 2]
  y -> [12 3]
  z -> [0 1]

julia> is_smooth(amb)
false

julia> t1 = blow_up(t, ["x", "y", "x1"]; coordinate_name = "e1")
Partially resolved global Tate model over a concrete base

julia> amb1 = ambient_space(t1)
Normal toric variety

julia> cox_ring(amb1)
Multivariate polynomial ring in 8 variables over QQ graded by
  x1 -> [1 0 0]
  x2 -> [0 1 0]
  x3 -> [0 1 0]
  x4 -> [0 1 0]
  x -> [1 1 2]
  y -> [1 2 3]
  z -> [0 -3 1]
  e1 -> [-1 1 0]

julia> t2 = blow_up(t1, ["y", "e1"]; coordinate_name = "e4")
Partially resolved global Tate model over a concrete base

julia> t3 = blow_up(t2, ["x", "e4"]; coordinate_name = "e2")
Partially resolved global Tate model over a concrete base

julia> t4 = blow_up(t3, ["y", "e2"]; coordinate_name = "e3")
Partially resolved global Tate model over a concrete base

julia> t5 = blow_up(t4, ["x", "y"]; coordinate_name = "s")
Partially resolved global Tate model over a concrete base

julia> tate_polynomial(t5);
```

```julia
julia> B3 = projective_space(NormalToricVariety, 3)
Normal toric variety

julia> W = torusinvariant_prime_divisors(B3)[1]
Torus-invariant, prime divisor on a normal toric variety

julia> t = literature_model(arxiv_id = "1109.3454", equation = "3.1", base_space = B3, model_sections = Dict("w" => W), completeness_check = false)
Construction over concrete base may lead to singularity enhancement. Consider computing singular_loci. However, this may take time!

Global Tate model over a concrete base -- SU(5)xU(1) restricted Tate model based on arXiv paper 1109.3454 Eq. (3.1)

julia> t5 = resolve(t, 1)
Partially resolved global Tate model over a concrete base -- SU(5)xU(1) restricted Tate model based on arXiv paper 1109.3454 Eq. (3.1)

julia> cox_ring(ambient_space(t5))
Multivariate polynomial ring in 12 variables over QQ graded by
  x1 -> [1 0 0 0 0 0 0]
  x2 -> [0 1 0 0 0 0 0]
  x3 -> [0 1 0 0 0 0 0]
  x4 -> [0 1 0 0 0 0 0]
  x -> [0 0 1 0 0 0 0]
  y -> [0 0 0 1 0 0 0]
  z -> [0 0 0 0 1 0 0]
  e1 -> [0 0 0 0 0 1 0]
  e4 -> [0 0 0 0 0 0 1]
  e2 -> [-1 -3 -1 1 -1 -1 0]
  e3 -> [0 4 1 -1 1 0 -1]
  s -> [2 6 -1 0 2 1 1]
```

