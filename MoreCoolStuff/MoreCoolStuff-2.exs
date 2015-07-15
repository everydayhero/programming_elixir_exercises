defmodule CsvSigil do

  def sigil_v(lines, _opts) do
    lines
    |> String.rstrip
    |> String.split("\n")
    |> Enum.reduce([], fn l, acc -> acc ++ [to_csv(l)] end)
  end

  def to_csv(values) do
    values 
    |> String.split(",") 
    |> Enum.reduce([], fn v, acc -> [parse(v) | acc] end)
    |> Enum.reverse
  end

  def parse(string), do: _parse(Float.parse(string), string)
  defp _parse({number, rest}, _string) when rest == "", do: number
  defp _parse(             _,  string)                , do: string
end

defmodule Example do
  import CsvSigil

  def lines do
    ~v"""
    1,2,3
    1,2,III
    a,b,c
    x,y,z
    """
  end
end