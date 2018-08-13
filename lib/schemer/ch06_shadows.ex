defmodule Schemer.Shadows do
  use Schemer.Primitive
  import Schemer.NumbersGames, only: [add: 2, times: 2, power: 2]

  @ops [:+, :*, :^]

  def numbered?(n) when number?(n), do: true
  def numbered?([n | [op | t]]) when number?(n) and op in @ops, do: numbered?(car(t))
  def numbered?(_), do: false

  def value(n) when number?(n), do: n
  def value([n | [:+ | t]]) when number?(n), do: add(n, value(car(t)))
  def value([n | [:* | t]]) when number?(n), do: times(n, value(car(t)))
  def value([n | [:^ | t]]) when number?(n), do: power(n, value(car(t)))

  def value_alt(n) when number?(n), do: n
  def value_alt([:+ | [sub1 | t]]), do: add(value_alt(sub1), value_alt(car(t)))
  def value_alt([:* | [sub1 | t]]), do: times(value_alt(sub1), value_alt(car(t)))
  def value_alt([:^ | [sub1 | t]]), do: power(value_alt(sub1), value_alt(car(t)))

  def value_final(n) when number?(n), do: n

  def value_final(aexp) do
    case operator(aexp) do
      :+ -> add(value_final(first_sub_exp(aexp)), value_final(second_sub_exp(aexp)))
      :* -> times(value_final(first_sub_exp(aexp)), value_final(second_sub_exp(aexp)))
      :^ -> power(value_final(first_sub_exp(aexp)), value_final(second_sub_exp(aexp)))
    end
  end

  def sero?(n), do: null?(n)
  def edd1(n), do: cons([], n)
  def zub1(n), do: cdr(n)

  def edd(a, b) do
    cond do
      sero?(b) -> a
      true -> edd(edd1(a), zub1(b))
    end
  end

  def operator(aexp), do: car(cdr(aexp))
  def first_sub_exp(aexp), do: car(aexp)
  def second_sub_exp(aexp), do: car(cdr(cdr(aexp)))
end
