defmodule MyList do

  def all?(list),     do: all?(list, fn x -> !!x end) # !! converts truthy to `true`
  def all?([], _func), do: true
  def all?([ head | tail ], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  def each([], _func), do: []
  def each([ head | tail ], func) do
    [ func.(head) | each(tail, func) ]
  end

  def filter([], _func), do: []
  def filter([ head | tail ], func) do
    if func.(head) do
      [ head, filter(tail, func) ]
    else
      [ filter(tail, func) ]
    end
  end

  def split(list, count),      do: _split(list, [], count)
  defp _split([], front, _),   do: [ Enum.reverse(front), [] ]
  defp _split(tail, front, 0), do: [ Enum.reverse(front), tail ]
  defp _split([ head | tail ], front, count)  do
    _split(tail, [head|front], count-1)
  end

  def take(list, n), do: hd(split(list, n))

end