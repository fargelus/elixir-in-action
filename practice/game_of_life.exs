defmodule Game do
  @rows 10
  @alive true

  def start do
    seed_universe() |> print
  end

  defp seed_universe do
    universe_size = @rows * @rows
    Enum.map_every(1..universe_size, 1, fn _ ->
      if :rand.uniform(4) == 1, do: @alive
    end)
  end

  defp print(generation) do
    generation
    |> Enum.with_index
    |> Enum.each(fn({cell, index}) ->
      cell == @alive && IO.write("🦠") || IO.write(" ")

      if index != 1 && rem(index, @rows) == 9 do
        IO.puts ""
      end
    end)
  end
end

Game.start
