defmodule ListModule do
  def len([]), do: 0

  def len([_ | tail]) do
    1 + length(tail)
  end

  def range(from, to)
    when not is_integer(from) or not is_integer(to) do
    {:error, "parameters must be integer"}
  end

  def range(from, from), do: [from]

  def range(from, to) when from > to, do: [from | range(from - 1, to)]

  def range(from, to) when from < to, do: [from | range(from + 1, to)]
end

defmodule ListModuleTest do
  def test do
    test_len()
    IO.puts ""
    test_range()
  end

  def test_len do
    IO.puts "*** Tests for len/1 fun ***"

    [] |> ListModule.len |> IO.puts # 0
    [1000] |> ListModule.len |> IO.puts # 1

    [1, 2, 3, -123, "afsd", 555]
      |> ListModule.len
      |> IO.puts # 6

    IO.puts "*** End of tests for len/1 func ***"
  end

  def test_range do
    IO.puts "*** Tests for range/2 fun ***"

    ListModule.range(1, 1) |> IO.inspect # []

    ListModule.range('a', 2) |> IO.inspect # error hash
    ListModule.range('a', []) |> IO.inspect # error hash
    ListModule.range(10, {}) |> IO.inspect # error hash

    ListModule.range(1, 3) |> IO.inspect # [1, 2, 3]
    ListModule.range(10, 1) |> IO.inspect # [10, 9, 8...]
    ListModule.range(1, 100) |> IO.inspect(limit: :infinity) # [1, 2, 3...]
    ListModule.range(1000000, 1) |> IO.inspect(limit: :infinity) # [1, 2, 3...]

    IO.puts "*** End of tests for range/1 fun ***"
  end
end

ListModuleTest.test
