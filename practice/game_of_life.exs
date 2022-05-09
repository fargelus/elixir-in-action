defmodule Game do
  @rows 10
  @alive true
  @lifeness_ratio 4

  def start do
    seed_universe() |> evolve
  end

  defp seed_universe do
    universe_size = @rows * @rows
    Enum.map_every(1..universe_size, 1, fn _ ->
      if :rand.uniform(@lifeness_ratio) == 1, do: @alive
    end)
  end

  defp evolve(generation, gen_count \\ 0) do
    generation |> print(gen_count)

    new_generation =
      Enum.with_index(generation)
      |> Enum.map(fn {cell, index} ->
        case count_neighbours(index, generation) do
          3 -> @alive
          2 -> cell
          _ -> nil
        end
    end)

    new_generation |> print(gen_count + 1)
  end

  defp count_neighbours(index, generation) do
    index
    |> neighbourhood
    |> Enum.filter(fn i -> i > 0 end)
    |> Enum.map(fn i -> Enum.at(generation, i) end)
    |> Enum.count(fn neighbour -> neighbour != nil end)
  end

  defp neighbourhood(index) do
    cond do
      rem(index, @rows) == 0 -> right_neighbourhood(index)
      rem(index, @rows) == @rows - 1 -> left_neighbourhood(index)

      true -> all_neighbourhood(index)
    end
  end

  defp right_neighbourhood(index) do
    [
      index + 1,
      index + @rows,
      index + @rows + 1
    ]
  end

  defp left_neighbourhood(index) do
    [
      index - 1,
      index + @rows,
      index + @rows - 1
    ]
  end

  defp all_neighbourhood(index) do
    [
      index + 1,
      index - 1,
      index + @rows,
      index + @rows + 1,
      index + @rows - 1,
      index - @rows,
      index - @rows + 1,
      index - @rows - 1
    ]
  end

  defp print(generation, gen_count) do
    IO.puts "Generation: #{gen_count}"

    generation
    |> Enum.with_index
    |> Enum.each(fn({cell, index}) ->
      cell == @alive && IO.write("🦠") || IO.write(" ")

      if index != 1 && rem(index, @rows) == @rows - 1 do
        IO.puts ""
      end
    end)
  end
end

Game.start
