defmodule Schemer.FullOfStars do
  use Schemer.Primitive
  import Schemer.NumbersGames, only: [add: 2, eqan?: 2]

  def rember_star(_, []), do: []
  def rember_star(a, [a | t]), do: rember_star(a, t)
  def rember_star(a, [h | t]) when atom?(h), do: cons(h, rember_star(a, t))
  def rember_star(a, [l | t]), do: cons(rember_star(a, l), rember_star(a, t))

  def insertR_star(_, _, []), do: []
  def insertR_star(new, old, [old | t]), do: cons(old, cons(new, insertR_star(new, old, t)))
  def insertR_star(new, old, [a | t]) when atom?(a), do: cons(a, insertR_star(new, old, t))
  def insertR_star(new, old, [l | t]), do: cons(insertR_star(new, old, l), insertR_star(new, old, t))

  def insertL_star(_, _, []), do: []
  def insertL_star(new, old, [old | t]), do: cons(new, cons(old, insertL_star(new, old, t)))
  def insertL_star(new, old, [a | t]) when atom?(a), do: cons(a, insertL_star(new, old, t))
  def insertL_star(new, old, [l | t]), do: cons(insertL_star(new, old, l), insertL_star(new, old, t))

  def occur_star(_, []), do: 0
  def occur_star(a, [a | t]), do: add1(occur_star(a, t))
  def occur_star(a, [b | t]) when atom?(b), do: occur_star(a, t)
  def occur_star(a, [l | t]), do: add(occur_star(a, l), occur_star(a, t))

  def subst_star(_, _, []), do: []
  def subst_star(new, old, [old | t]), do: cons(new, subst_star(new, old, t))
  def subst_star(new, old, [a | t]) when atom?(a), do: cons(a, subst_star(new, old, t))
  def subst_star(new, old, [l | t]), do: cons(subst_star(new, old, l), subst_star(new, old, t))

  def member_star(_, []), do: false
  def member_star(a, [a | _]), do: true
  def member_star(a, [b | t]) when atom?(b), do: member_star(a, t)
  def member_star(a, [l | t]), do: member_star(a, l) || member_star(a, t)

  def leftmost([a | _]) when atom?(a), do: a
  def leftmost([l | _]), do: leftmost(l)

  def eqlist?([], []), do: true
  def eqlist?(_, []), do: false
  def eqlist?([], _), do: false
  def eqlist?([h1 | t1], [h2 | t2]), do: equal?(h1, h2) && eqlist?(t1, t2)

  def equal?(a, b) when atom?(a) and atom?(b), do: eqan?(a, b)
  def equal?(a, _) when atom?(a), do: false
  def equal?(_, b) when atom?(b), do: false
  def equal?(l1, l2), do: eqlist?(l1, l2)
end
