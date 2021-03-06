defmodule Crash2 do

  def one_time(sender) do
    send sender, "Just a message from Crash2"
    raise RuntimeError, message: "Did it by purpose"
  end

  def check_for_message do
    receive do
       msg ->
        IO.puts "Received another message #{inspect msg}"
        check_for_message
    after 500 ->
      IO.puts "no more messages"
    end
  end

  def run do
    Process.flag(:trap_exit, true)
    res = spawn_link(Crash2, :one_time, [self])

    IO.puts inspect res

    :timer.sleep(500)

    check_for_message
  end
end