defmodule ListModule do
  def rec_len(list) do
    make_rec_len(list, 0)
  end

  defp make_rec_len([], size), do: size

  defp make_rec_len([_ | tail], size) do
    make_rec_len(tail, size + 1)
  end
end

defmodule ListModuleTest do
  def test do
    test_rec_len()
  end

  def test_rec_len do
    IO.puts "*** Tests for rec_len/1 fun ***"

    [] |> ListModule.rec_len |> IO.puts # 0
    [1] |> ListModule.rec_len |> IO.puts # 1
    [1, 2, 3, -123, "afsd", 555]
      |> ListModule.rec_len
      |> IO.puts # 6

    Enum.to_list(1..100000000) |> ListModule.rec_len |> IO.puts
    IO.puts "*** End of tests for req_len/1 func ***"
  end
end

ListModuleTest.test
