defmodule CsvSigil do

  def sigil_v(lines, _opts) do
    [head | tail] = lines
                    |> String.rstrip
                    |> String.split("\n")
    header = String.split(head, ",")
    Enum.reduce(tail, [], fn l, acc -> acc ++ [assign(to_csv(l), header)] end)
  end

  def assign([value | values], [first | rest]) do
    [{String.to_atom(first), value} | assign(values, rest)]
  end
  def assign([],[]), do: []

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
    Item,Qty,Price
    Teddy bear,4,34.95
    Milk,1,2.99
    Battery,6,8.00
    """
  end
end