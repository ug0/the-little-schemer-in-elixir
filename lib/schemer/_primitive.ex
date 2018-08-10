defmodule Schemer.Primitive do
  def add1(n), do: n + 1

  def sub1(n), do: n - 1

  def zero?(n), do: n == 0

  def car([h | _]), do: h

  def cdr([_ | t]), do: t

  def cons(h, t), do: [h | t]

  def null?([]), do: true
  def null?(_), do: false

  defmacro atom?(n) do
    quote do
      is_atom(unquote(n)) or is_integer(unquote(n))
    end
  end

  defmacro number?(n) do
    quote do
      is_integer(unquote(n))
    end
  end

  def eq?(a, b) when atom?(a) and atom?(b), do:  a == b

  defmacro __using__(_) do
    quote do
      import Kernel, except: [div: 2, length: 1]
      import unquote(__MODULE__)
    end
  end
end
