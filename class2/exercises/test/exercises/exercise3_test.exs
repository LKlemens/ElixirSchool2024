defmodule Exercises.Exercise3Test do
  use ExUnit.Case, async: false

  @tag :test3
  test "Should return pid, register it under :hello name, handle msg and termiante" do
    pid = Exercises.Exercise3.wait_and_print()
    assert is_pid(pid) == true, "Function should return pid"
    Process.sleep(300)
    assert Process.alive?(pid) == true, "Process should wait for a :ping message"
    send(pid, :ping)
    Process.sleep(300)
    assert Process.alive?(pid) == false, "Process should terminate after receiving msg"
  end
end
