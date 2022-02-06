defmodule ListModule do
  def rec_len(list) do
    make_rec_len(list, 0)
  end

  def rec_range(from, to) do
    make_rec_range(from, to, [])
  end

  defp make_rec_range(to, to, list), do: [to | list]

  defp make_rec_range(from, to, list) do
    dec = if from < to, do: -1, else: 1
    make_rec_range(from, to + dec, [to | list])
  end

  defp make_rec_len([], size), do: size

  defp make_rec_len([_ | tail], size) do
    make_rec_len(tail, size + 1)
  end
end

defmodule ListModuleTest do
  def test do
    test_rec_len()
    IO.puts ""
    test_req_range()
  end

  def test_rec_len do
    IO.puts "*** Tests for rec_len/0 fun ***"

    [] |> ListModule.rec_len |> IO.puts # 0
    [1] |> ListModule.rec_len |> IO.puts # 1
    [1, 2, 3, -123, "afsd", 555]
      |> ListModule.rec_len
      |> IO.puts # 6

    Enum.to_list(1..100000000) |> ListModule.rec_len |> IO.puts
    IO.puts "*** End of tests for req_len/0 func ***"
  end

  def test_req_range do
    IO.puts "*** Tests for rec_range/0 fun ***"

    ListModule.rec_range(1, 1) |> IO.inspect # [1]
    ListModule.rec_range(1, 10) |> IO.inspect # [1..10]
    ListModule.rec_range(10, 1) |> IO.inspect # [10..1]
    ListModule.rec_range(1, 100) |> IO.inspect(limit: :infinity)
    ListModule.rec_range(1, 1000000) |> IO.inspect(limit: :infinity)

    IO.puts "*** End of tests for rec_range/0 fun ***"
  end
end

ListModuleTest.test
