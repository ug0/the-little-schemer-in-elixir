defmodule Schemer.Toys do
  @doc """
  ## The Law of Car

  The primitive car is defined only for non-empty lists.
  """
  def car([h | _]), do: h

  @doc """
  ## The Law of Cdr

  The primitive cdr is defined only for non-empty lists. \
  The cdr of any non­ empty list is always another list.
  """
  def cdr([_ | t]), do: t

  @doc """
  ## The Law of Cons

  The primitive cons takes two arguments. \
  The second argument to cons must be a \
  list. The result is a list.
  """
  def cons(a, l), do: [a | l]

  @doc """
  ## The Law of Null?

  The primitive null? is de­fined only for lists.

  """
  def null?([]), do: true
  def null?(_), do: false

  @doc """
  #The Law of Eq?

  The primitive eq? takes two ar­guments. \
  Each must be a non­ numeric atom.
  """
  def eq?(a, a) when is_atom(a), do: true
  def eq?(a, b) when is_atom(a) and is_atom(b), do: false
end
