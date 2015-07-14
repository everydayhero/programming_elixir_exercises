defmodule MyString do
  def anagram(sqs1, sqs2), do: Enum.reverse(sqs1) == sqs2
end