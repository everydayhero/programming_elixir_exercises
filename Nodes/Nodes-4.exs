defmodule RingTicker do
  @interval 2000
  @master :ring_ticker_master

  def join do
    pid = spawn(__MODULE__, :wait, [])
    case :global.whereis_name(@master) do
      :undefined ->
        send pid, {:become_master, [pid]}
      master_pid ->
        send master_pid, {:join, pid}
    end
  end

  def tick(queue) do
    receive do
      {:join, pid} ->
        IO.puts "join #{inspect pid}"
        tick(queue ++ [pid])
      after @interval ->
        IO.puts "tick #{inspect :erlang.localtime}"
        [next | rest] = queue
        new_queue = rest ++ [next]
        send next, {:become_master, new_queue}
        wait
    end
  end

  def wait do
    receive do
      {:become_master, new_queue} ->
        :global.re_register_name(@master, self)
        tick(new_queue)
    end
  end
end