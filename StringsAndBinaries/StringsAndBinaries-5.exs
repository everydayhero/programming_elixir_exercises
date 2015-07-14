defmodule MyString do
  def center(strings) do
    strings 
    |> center_strings 
    |> Enum.each &IO.puts/1
  end

  def center_strings(strings) do
    max_length = strings |> Enum.map(&String.length/1) |> Enum.max
    in_width = fn (string) ->
      l = String.length string
      div(max_length - l, 2) + l
    end
    strings |> Enum.map &(String.rjust(&1, in_width.(&1)))
  end
end
