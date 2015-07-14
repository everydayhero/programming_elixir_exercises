defmodule MyString do
  def capitalize_sentences(string) do
    String.split(string, ~r{(?<=\. )(?=.)})
    |> Enum.map(&String.capitalize/1)
    |> Enum.join
  end
end