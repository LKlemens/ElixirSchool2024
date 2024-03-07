defmodule WordleBroadwayTest do
  use ExUnit.Case
  doctest WordleBroadway

  test "greets the world" do
    assert WordleBroadway.hello() == :world
  end
end
