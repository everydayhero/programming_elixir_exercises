defmodule My do
  defmacro myunless(condition, clauses) do
    do_clause   = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(do_clause)
        _                            -> unquote(else_clause)
      end
    end
  end
end

defmodule Testmyunless do
  require My
  import  My

  myunless 1 == 1 do
    IO.puts ">: 1 != 1"
  else
    IO.puts ">: 1 == 1"
  end

  myunless 2 == 3 do
    IO.puts ">: 2 != 3"
  else
    IO.puts ">: 2 == 3"
  end
end