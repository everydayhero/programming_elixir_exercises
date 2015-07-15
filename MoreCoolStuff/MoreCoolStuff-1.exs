defmodule CsvSigil do

  def sigil_v(lines, _opts) do
    lines
    |> String.rstrip
    |> String.split("\n")
    |> Enum.reduce([], fn l, acc -> acc ++ [String.split(l)] end)
  end

end

defmodule Example do
  import CsvSigil

  def lines do
    ~v"""
    1,2,3
    a,b,c
    x,y,z
    """
  end
end