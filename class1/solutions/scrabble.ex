defmodule Scrabble do
  def calculate_score(word) do
    word
    |> String.graphemes()
    |> Enum.map(&letter_score/1)
    |> Enum.sum()
  end

  defp letter_score(letter) do
    cond do
      String.contains?("aeioulnrst", letter) -> 1
      String.contains?("dg", letter) -> 2
      String.contains?("bcmp", letter) -> 3
      String.contains?("fhvwy", letter) -> 4
      String.contains?("k", letter) -> 5
      String.contains?("jx", letter) -> 8
      String.contains?("qz", letter) -> 10
    end
  end
end

