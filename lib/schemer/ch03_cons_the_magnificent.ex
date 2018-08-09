defmodule Schemer.ConsTheMagnificent do
  import Schemer.Toys, only: [cons: 2]

  def rember(_, []), do: []
  def rember(a, [a | t]), do: t
  def rember(a, [h | t]), do: cons(h, rember(a, t))

  def firsts([]), do: []
  def firsts([[h | _] | l]), do: cons(h, firsts(l))

  def insertR(_, _, []), do: []
  def insertR(new, old, [old | t]), do: cons(old, [new | t])
  def insertR(new, old, [h | t]), do: cons(h, insertR(new, old, t))

  def insertL(_, _, []), do: []
  def insertL(new, old, [old | _] = l), do: cons(new, l)
  def insertL(new, old, [h | t]), do: cons(h, insertL(new, old, t))

  def subst(_, _, []), do: []
  def subst(new, old, [old | t]), do: cons(new, t)
  def subst(new, old, [h | t]), do: cons(h, subst(new, old, t))

  def subst2(_, _, _, []), do: []
  def subst2(new, o1, _o2, [o1 | t]), do: cons(new, t)
  def subst2(new, _o1, o2, [o2 | t]), do: cons(new, t)
  def subst2(new, o1, o2, [h | t]), do: cons(h, subst2(new, o1, o2, t))

  def multirember(_, []), do: []
  def multirember(a, [a | t]), do: multirember(a, t)
  def multirember(a, [h | t]), do: cons(h, multirember(a, t))

  def multiinsertR(_, _, []), do: []
  def multiinsertR(new, old, [old | t]), do: cons(old, [new | multiinsertR(new, old, t)])
  def multiinsertR(new, old, [h | t]), do: cons(h, multiinsertR(new, old, t))

  def multiinsertL(_, _, []), do: []
  def multiinsertL(new, old, [old | t]), do: cons(new, [old | multiinsertL(new, old, t)])
  def multiinsertL(new, old, [h | t]), do: cons(h, multiinsertL(new, old, t))
end
