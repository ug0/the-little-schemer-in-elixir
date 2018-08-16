defmodule Schemer.FriendsAndRelations do
  use Schemer.Primitive
  import Schemer.DoItAgain, only: [member?: 2]
  import Schemer.ConsTheMagnificent, only: [multirember: 2, firsts: 1]

  def set?([]), do: true
  def set?([h | t]), do: !member?(h, t) && set?(t)

  def makeset([]), do: []

  def makeset([a | l]) do
    cond do
      member?(a, l) -> cons(a, makeset(multirember(a, l)))
      true -> cons(a, makeset(l))
    end
  end

  def subset?([], _), do: true
  def subset?([h | t], s2), do: member?(h, s2) && subset?(t, s2)

  def eqset?(s1, s2), do: subset?(s1, s2) && subset?(s2, s1)

  def intersect?([], _), do: false
  def intersect?([h | t], s2), do: member?(h, s2) || intersect?(t, s2)

  def intersect([], _), do: []

  def intersect([h | t], s2) do
    cond do
      member?(h, s2) -> cons(h, intersect(t, s2))
      true -> intersect(t, s2)
    end
  end

  def union([], s2), do: s2

  def union([h | t], s2) do
    cond do
      member?(h, s2) -> union(t, s2)
      true -> cons(h, union(t, s2))
    end
  end

  def intersectall([s | []]), do: s
  def intersectall([s1 | t]), do: intersect(s1, intersectall(t))

  def a_pair?([_ | [ _ | []]]), do: true
  def a_pair?(_), do: false

  def first(l), do: car(l)
  def second(l), do: car(cdr(l))
  def third(l), do: car(cdr(cdr(l)))
  def build(s1, s2), do: cons(s1, cons(s2, []))

  def fun?(rel), do: set?(firsts(rel))

  def revrel([]), do: []
  def revrel([pair | rel]), do: cons(revpair(pair), revrel(rel))
  def revpair(pair), do: build(second(pair), first(pair))

  def fullfun?(rel), do: set?(seconds(rel))
  def seconds([]), do: []
  def seconds([a | rel]), do: cons(second(a), seconds(rel))
end
