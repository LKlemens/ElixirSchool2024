defmodule Recursive do
  def sum(n) do
    sum_recursive(n)
  end

  def sum_recursive(0) do
    0
  end

  def sum_recursive(n) do
    n + sum_recursive(n - 1)
  end

  def sum_tail_recursive(0, acc) do
    acc
  end

  def sum_tail_recursive(n, acc) do
    sum_tail_recursive(n - 1, acc + n)
  end
end

