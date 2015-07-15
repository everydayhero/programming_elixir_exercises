defmodule My do
  defmacro times_n(value) do
    name = :"times_#{value}"
    quote do
      def unquote(name)(x), do: unquote(value) * x 
    end
  end
end

defmodule TestTimes do
  require My

  My.times_n(3)
  My.times_n(4)
end