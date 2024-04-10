defmodule Exercises.Exercise2Test do
  use ExUnit.Case, async: false

  @tag :test2
  test "Should create a new process and register it under :hello name" do
    pid = Exercises.Exercise2.create_registered_process()
    Process.sleep(200)
    assert is_pid(pid) == true, "Function should return pid"
    assert Process.whereis(:hello) != nil, "Process should be registered under :hello name"
  end
end
