defmodule MyString do
  def printable_ascii(sqs), do: Enum.all?(sqs, fn ch -> ch in ? ..?~ end)
end