defmodule Schemer.NumbersGames do
  use Schemer.Primitive

  def add(a, 0), do: a
  def add(a, b), do: add(1 + a, b - 1)

  def sub(a, 0), do: a
  def sub(a, b), do: sub(a - 1, b - 1)

  def addtup([]), do: 0
  def addtup([h | t]), do: add(h, addtup(t))

  def times(_, 0), do: 0
  def times(a, b), do: add(a, times(a, b - 1))

  def tupadd([], l), do: l
  def tupadd(l, []), do: l
  def tupadd(a, b), do: cons(add(car(a), car(b)), tupadd(cdr(a), cdr(b)))

  def greaterthan?(0, _), do: false
  def greaterthan?(_, 0), do: true
  def greaterthan?(a, b), do: greaterthan?(a - 1, b - 1)

  def lessthan?(_, 0), do: false
  def lessthan?(0, _), do: true
  def lessthan?(a, b), do: lessthan?(a - 1, b - 1)

  def equalnum?(a, b), do: !greaterthan?(a, b) && !lessthan?(a, b) && true

  def power(_, 0), do: 1
  def power(a, b), do: times(a, power(a, b - 1))

  def div(a, b) do
    cond do
      lessthan?(a, b) -> 0
      true -> 1 + div(sub(a, b), b)
    end
  end

  def length([]), do: 0
  def length(l), do: 1 + length(cdr(l))

  def pick(1, [h | _]), do: h
  def pick(n, l), do: pick(n - 1, cdr(l))

  def rempick(n, l) do
    cond do
      one?(n) -> cdr(l)
      true -> cons(car(l), rempick(n-1, cdr(l)))
    end
  end

  def non_nums([]), do: []
  def non_nums([n | t]) when number?(n), do: non_nums(t)
  def non_nums([a | t]), do: cons(a, non_nums(t))

  def all_nums([]), do: []
  def all_nums([n | t]) when number?(n), do: cons(n, all_nums(t))
  def all_nums([_ | t]), do: all_nums(t)

  def eqan?(a, b) when atom?(a) and atom?(b), do: eq?(a, b)
  def eqan?(a, b) when number?(a) and number?(b), do: equalnum?(a, b)
  def eqan?(_, _), do: false

  def occur(_, []), do: 0
  def occur(a, [a | t]), do: 1 + occur(a, t)
  def occur(a, [_ | t]), do: occur(a, t)

  def one?(n), do: eqan?(1, n)
end
