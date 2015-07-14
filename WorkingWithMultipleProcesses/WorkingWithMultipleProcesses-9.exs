defmodule WordCounter do

  def count(scheduler, file, word) do
    send scheduler, { self, { file, count_words(word, file) } }
  end

  defp _count_words({:ok, regex}, file), 
    do: Regex.scan(regex, File.read!(file)) |> length
  defp _count_words({:error, reason}, _file), do: -1
  def count_words(word, file), 
    do: _count_words(Regex.compile("#{word}"), file)

end

defmodule Scheduler do

  def schedule(module, function, data, args) do
    data
    |> Enum.map(fn(d) -> spawn(module, function, [self, d, args]) end)
    |> collect_results([])
  end

  def collect_results(processes, results) do
    receive do
      { child, result } when length(processes) > 1 ->
        collect_results(List.delete(processes, child), [result | results ]) 
      { _child, result } ->
        [ result | results ]
    end
  end

end

{ _, wd } = File.cwd
File.cd!("test-files/")
IO.puts "Start word count"
Scheduler.schedule(WordCounter, :count, File.ls!, "cat")
|> Enum.map(fn({file, count}) ->
  :io.format "~-30s     ~10B~n", [file, count]
end)
IO.puts "End word count"
File.cd! wd