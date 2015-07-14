defmodule MyList do
  def span(from,to) when from > to, do: []
  def span(from,to), do: [from | span(from+1, to)]
  
  def prime(a,b) when 1 < a and a < b do
    for x <- span(a,b), _prime(x), do: x
  end
  def _prime(2), do: true
  def _prime(a) when a > 2 do
    !((for x <- span(2,a-1), do: rem(a,x) == 0) |> Enum.any?)
  end
end