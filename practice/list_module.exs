defmodule ListModule do
  def len([]), do: 0

  def len([_ | tail]) do
    1 + length(tail)
  end
end

defmodule ListModuleTest do
  def test_len do
    [] |> ListModule.len |> IO.puts # 0
    [1000] |> ListModule.len |> IO.puts # 1

    [1, 2, 3, -123, 'afsd', 555]
      |> ListModule.len
      |> IO.puts # 6
  end
end

ListModuleTest.test_len
