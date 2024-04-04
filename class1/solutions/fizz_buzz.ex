defmodule FizzBuzz do
  def fizzbuzz(n) do
    fizzbuzz_recursive(n)
  end

  defp fizzbuzz_recursive(0) do
    []
  end

  defp fizzbuzz_recursive(n) do
    [map_number(n) | fizzbuzz_recursive(n - 1)]
  end

  defp fizzbuzz_tail_recursive(0, acc) do
    acc
  end

  defp fizzbuzz_tail_recursive(n, acc) do
    fizzbuzz_tail_recursive(n - 1, [map_number(n) | acc])
  end

  defp fizzbuzz_higher_order_f(n) do
    1..n//1
    |> Enum.map(&map_number/1)
  end

  defp fizzbuzz_comprehension(n) do
    for i <- 1..n//1, do: map_number(i)
  end

  defp map_number(n) do
    by_3 = rem(n, 3) == 0
    by_5 = rem(n, 5) == 0
    cond do
      by_3 and by_5 -> :fizzbuzz
      by_3 -> :fizz
      by_5 -> :buzz
      true -> n
    end
  end
end

