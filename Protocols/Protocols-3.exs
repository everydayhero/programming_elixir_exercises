defmodule MyEnum do
  def each(collection, fun) do
    reducer = fn x, acc ->
      fun.(x)
      {:cont, acc}
    end
    {:done, _} = Enumerable.reduce collection, {:cont, []}, reducer
    :ok
  end

  def map(collection, fun) do
    reducer = fn x, acc ->
      {:cont, acc ++ [fun.(x)]}
    end
    {:done, result} = Enumerable.reduce collection, {:cont, []}, reducer
    result
  end

  def filter(collection, fun) do
    reducer = fn x, acc ->
      if fun.(x) do
        {:cont, acc ++ [x]}
      else
        {:cont, acc}
      end
    end
    {:done, result} = Enumerable.reduce collection, {:cont, []}, reducer
    result
  end
end