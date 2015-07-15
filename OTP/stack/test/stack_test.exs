defmodule StackTest do
  use ExUnit.Case

  test "the application" do
    { stack, pid } = :sys.get_state Stack.Server
    assert stack == [1,2,3]
    refute pid == nil

    assert Stack.Server.pop == 1

    stack = for x <- 1..2, do: Stack.Server.pop
    assert stack = [2,3]
    { empty_stack, pid } = :sys.get_state Stack.Server
    assert empty_stack == []

    Stack.Server.push 1234
    { stack, _ } = :sys.get_state Stack.Server
    assert stack == [1234]
  end

end