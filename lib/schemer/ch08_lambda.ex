defmodule Schemer.Lambda do
  use Schemer.Primitive
  import Schemer.NumbersGames, only: [add: 2, times: 2, power: 2, div: 2, equalnum?: 2]
  import Schemer.Shadows, only: [operator: 1, first_sub_exp: 1, second_sub_exp: 1]

  def rember_f(test?) do
    fn
      _, [] ->
        []

      a, [h | t] ->
        cond do
          test?.(a, h) -> t
          true -> cons(h, rember_f(test?).(a, t))
        end
    end
  end

  def insertL_f(test?) do
    fn
      _, _, [] ->
        []

      new, old, [h | t] = l ->
        cond do
          test?.(old, h) -> cons(new, l)
          true -> cons(h, insertL_f(test?).(new, old, t))
        end
    end
  end

  def insertR_f(test?) do
    fn
      _, _, [] ->
        []

      new, old, [h | t] ->
        cond do
          test?.(old, h) -> cons(old, cons(new, t))
          true -> cons(h, insertR_f(test?).(new, old, t))
        end
    end
  end

  def multirember_f(test?) do
    fn
      _, [] ->
        []

      a, [h | t] ->
        cond do
          test?.(a, h) -> multirember_f(test?).(a, t)
          true -> cons(h, multirember_f(test?).(a, t))
        end
    end
  end

  def multiremberT(_, []), do: []

  def multiremberT(test?, [h | t]) do
    cond do
      test?.(h) -> multiremberT(test?, t)
      true -> cons(h, multiremberT(test?, t))
    end
  end

  def multirember_and_co(_, [], col), do: col.([], [])

  def multirember_and_co(a, [h | t], col) do
    cond do
      eq?(a, h) ->
        multirember_and_co(a, t, fn newlat, seen ->
          col.(newlat, cons(h, seen))
        end)

      true ->
        multirember_and_co(a, t, fn newlat, seen ->
          col.(cons(h, newlat), seen)
        end)
    end
  end

  def multiinsertLR(_, _, _, []), do: []

  def multiinsertLR(new, oldL, oldR, [h | t]) do
    cond do
      eq?(oldL, h) -> cons(new, cons(h, multiinsertLR(new, oldL, oldR, t)))
      eq?(oldR, h) -> cons(h, cons(new, multiinsertLR(new, oldL, oldR, t)))
      true -> cons(h, multiinsertLR(new, oldL, oldR, t))
    end
  end

  def multiinsertLR_and_co(_, _, _, [], col), do: col.([], 0, 0)

  def multiinsertLR_and_co(new, oldL, oldR, [h | t], col) do
    cond do
      eq?(oldL, h) ->
        multiinsertLR_and_co(new, oldL, oldR, t, fn newlat, cl, cr ->
          col.(cons(new, cons(h, newlat)), add1(cl), cr)
        end)

      eq?(oldR, h) ->
        multiinsertLR_and_co(new, oldL, oldR, t, fn newlat, cl, cr ->
          col.(cons(h, cons(new, newlat)), cl, add1(cr))
        end)

      true ->
        multiinsertLR_and_co(new, oldL, oldR, t, fn newlat, cl, cr ->
          col.(cons(h, newlat), cl, cr)
        end)
    end
  end

  def insert_g(seq) do
    fn
      _, _, [] ->
        []

      new, old, [h | t] ->
        cond do
          eq?(old, h) -> seq.(new, old, t)
          true -> cons(h, insert_g(seq).(new, old, t))
        end
    end
  end

  def insertL(new, old, l) do
    insert_g(fn new, old, l -> cons(new, cons(old, l)) end).(new, old, l)
  end

  def insertR(new, old, l) do
    insert_g(fn new, old, l -> cons(old, cons(new, l)) end).(new, old, l)
  end

  def subst(new, old, l) do
    insert_g(fn new, _old, l -> cons(new, l) end).(new, old, l)
  end

  def atom_to_function(x) do
    case x do
      :+ -> &add/2
      :* -> &times/2
      :^ -> &power/2
    end
  end

  def value(nexp) do
    cond do
      atom?(nexp) ->
        nexp

      true ->
        atom_to_function(operator(nexp)).(value(first_sub_exp(nexp)), value(second_sub_exp(nexp)))
    end
  end

  def evens_only_star([]), do: []

  def evens_only_star([n | t]) when number?(n) do
    cond do
      even?(n) -> cons(n, evens_only_star(t))
      true -> evens_only_star(t)
    end
  end

  def evens_only_star([h | t]), do: cons(evens_only_star(h), evens_only_star(t))

  def evens_only_star_and_co([], col), do: col.([], 1, 0)

  def evens_only_star_and_co([n | t], col) when number?(n) do
    cond do
      even?(n) ->
        evens_only_star_and_co(t, fn newl, p, s ->
          col.(cons(n, newl), times(p, n), s)
        end)

      true ->
        evens_only_star_and_co(t, fn newl, p, s ->
          col.(newl, p, add(s, n))
        end)
    end
  end

  def evens_only_star_and_co([h | t], col) do
    evens_only_star_and_co(h, fn al, ap, as ->
      evens_only_star_and_co(t, fn dl, dp, ds ->
        col.(cons(al, dl), times(ap, dp), add(as, ds))
      end)
    end)
  end

  def even?(n), do: equalnum?(n, times(div(n, 2), 2))
end
