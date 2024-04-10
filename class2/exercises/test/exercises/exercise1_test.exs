defmodule Exercises.Exercise1Test do
  use ExUnit.Case, async: false

  @tag :test1
  test "Should return pid and send :ping to :pong process" do
    Process.register(self(), :ping)
    pid = Exercises.Exercise1.send_to_pong()
    assert is_pid(pid) == true, "Function should return pid"
    assert_receive :pong, 100, "Process should send :pong message to :ping proccess"
  end
end
