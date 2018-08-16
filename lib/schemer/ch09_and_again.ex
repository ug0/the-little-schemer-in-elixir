defmodule Schemer.AndAgain do
  use Schemer.Primitive

  import Schemer.NumbersGames, only: [pick: 2, add: 2, times: 2, div: 2, one?: 1]

  import Schemer.FriendsAndRelations,
    only: [first: 1, second: 1, build: 2, a_pair?: 1, revpair: 1]

  import Schemer.Lambda, only: [even?: 1]

  def looking(a, lat), do: keep_looking(a, pick(1, lat), lat)

  def keep_looking(expect, find, lat) when number?(find),
    do: keep_looking(expect, pick(find, lat), lat)

  def keep_looking(expect, find, _lat), do: eq?(expect, find)

  def shift(pair) do
    build(first(first(pair)), build(second(first(pair)), second(pair)))
  end

  def align(pora) do
    cond do
      atom?(pora) -> pora
      a_pair?(first(pora)) -> align(shift(pora))
      true -> build(first(pora), align(second(pora)))
    end
  end

  def length_star(pora) do
    cond do
      atom?(pora) -> 1
      true -> add(length_star(first(pora)), length_star(second(pora)))
    end
  end

  def weight_star(pora) do
    cond do
      atom?(pora) -> 1
      true -> add(times(weight_star(first(pora)), 2), weight_star(second(pora)))
    end
  end

  def shuffle(pora) do
    cond do
      atom?(pora) ->
        pora

      a_pair?(first(pora)) ->
        shuffle(revpair(pora))

      true ->
        build(first(pora), shuffle(second(pora)))
    end
  end

  def eternity(x) do
    eternity(x)
  end

  def _C(n) do
    cond do
      one?(n) -> 1
      even?(n) -> _C(div(n, 2))
      true -> _C(add1(times(3, n)))
    end
  end

  def _A(n, m) do
    cond do
      zero?(n) ->
        IO.puts(m + 1)
        add1(m)

      zero?(m) ->
        IO.puts("A(#{n - 1} 1)")
        _A(sub1(n), 1)

      true ->
        IO.puts("A(#{n - 1} A(#{n} #{m - 1}))")
        _A(sub1(n), _A(n, sub1(m)))
    end
  end

  def length0(l) do
    cond do
      null?(l) -> 0
      true -> add1(eternity(cdr(l)))
    end
  end

  def length_le2_f do
    (fn length ->
       fn l ->
         cond do
           null?(l) -> 0
           true -> add1(length.(cdr(l)))
         end
       end
     end).(
      (fn length ->
         fn l ->
           cond do
             null?(l) -> 0
             true -> add1(length.(cdr(l)))
           end
         end
       end).(
        (fn length ->
           fn l ->
             cond do
               null?(l) -> 0
               true -> add1(length.(cdr(l)))
             end
           end
         end).(&eternity/1)
      )
    )
  end

  # def length_f do
  #   (fn mk_length ->
  #      mk_length.(mk_length)
  #    end).(fn mk_length ->
  #     fn l ->
  #       cond do
  #         null?(l) -> 0
  #         true -> add1(mk_length.(mk_length).(cdr(l)))
  #       end
  #     end
  #   end)
  # end

  def length_f do
    (fn mk_length ->
       mk_length.(mk_length)
     end).(fn mk_length ->
      (fn length ->
         fn l ->
           cond do
             null?(l) -> 0
             true -> add1(length.(cdr(l)))
           end
         end
       end).(fn x -> mk_length.(mk_length).(x) end)
    end)
  end

  def y do
    fn le ->
      (fn f ->
         f.(f)
       end).(fn f ->
        le.(fn x -> f.(f).(x) end)
      end)
    end
  end
end
