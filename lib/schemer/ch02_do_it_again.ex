defmodule Schemer.DoItAgain do
  import Schemer.Primitive, only: [atom?: 1]

  def lat?([]), do: true
  def lat?([h | t]) when atom?(h), do: lat?(t)
  def lat?(_), do: false

  def member?(_, []), do: false
  def member?(a, [a | _]), do: true
  def member?(a, [_ | t]), do: member?(a, t)
end
