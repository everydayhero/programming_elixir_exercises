defmodule Check do

  def ok!(p) do
    case p do
      {:ok, data}  -> data
      {_, message} -> raise "Exception occurred: #{message}"
    end
  end

end