defmodule Crash3 do

  def one_time(sender) do
    send sender, {self, "Just a message from Crash3"}
    raise RuntimeError, message: "Did it by purpose"
  end

  def check_for_message do
    receive do
      {sender, msg} ->
        IO.puts "Received message #{inspect msg} from #{inspect sender}"
        check_for_message
       msg ->
        IO.puts "Received another message #{inspect msg}"
        check_for_message
    after 500 ->
      IO.puts "no more messages"
    end
  end

  def run do
    res = spawn_monitor(Crash2, :one_time, [self])

    IO.puts inspect res

    :timer.sleep(500)

    check_for_message
  end
end

defmodule Crash4 do

  def one_time(sender) do
    send sender, {self, "Just a message from Crash4"}
    exit "Did it by purpose"
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
    res = spawn_monitor(Crash4, :one_time, [self])

    IO.puts inspect res

    :timer.sleep(500)

    check_for_message
  end
end
