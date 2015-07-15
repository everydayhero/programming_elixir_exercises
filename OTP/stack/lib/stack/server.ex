defmodule Stack.Server do
  use GenServer

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def push(element) do
    GenServer.cast __MODULE__, {:push, element}
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def init(stash_pid) do
    list = Stack.Stash.get_value stash_pid
    { :ok, {list, stash_pid} }
  end

  def handle_call(:pop, _from, {list, stash_pid}) do
    [ head | tail ] = list
    { :reply, head, {tail, stash_pid} }
  end

  def handle_cast({:push, element}, {list, stash_pid}) do
    bug(element)
    new_list = [ element | list ]
    { :noreply, {new_list, stash_pid} }
  end

  def terminate(_reason, {list, stash_pid}) do
    Stack.Stash.save_value stash_pid, list
  end

  defp bug("fail") do raise "Invalid push value 'fail'" end
  defp bug(_) do end
end