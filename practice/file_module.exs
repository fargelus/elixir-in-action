defmodule FileModule do
  def line_lengths!(path) do
    lines!(path) |> Enum.map(fn line -> String.length(line) end)
  end

  def longest_line_length!(path) do
    line_lengths!(path) |> Enum.max
  end

  def longest_line!(path) do
    lines!(path) |> Enum.max_by(fn line -> String.length(line) end)
  end

  def words_per_line(path) do
    lines!(path) |> Enum.map(&count_words_per_line/1)
  end

  def test_all do
    file_path = "./file_module.exs"

    line_lengths!(file_path) |> IO.inspect(limit: :infinity)
    longest_line_length!(file_path) |> IO.puts
    longest_line!(file_path) |> IO.puts
    words_per_line(file_path) |> IO.inspect
  end

  defp lines!(path) do
    File.read!(path) |> String.split("\n")
  end

  defp count_words_per_line(line) do
    String.split(line, ~r{\s})
    |> Enum.reject(fn word -> String.equivalent?(word, "") end)
    |> Enum.count
  end
end

FileModule.test_all
