defmodule Exercises.Exercise4Test do
  use ExUnit.Case, async: false

  @tag :test4
  test "Should send :timeout messgae after 500ms" do
    Process.register(self(), :test)
    pid = Exercises.Exercise4.send_timeout()
    assert is_pid(pid) == true, "Function should return pid"

    refute_receive :timeout,
                   300,
                   ":test process should get :timeout message after 500ms - not earlier"

    assert Process.alive?(pid) == true, "Process should wait for a :ping message"
    Process.sleep(300)
    assert_receive :timeout, 200, "Process :hello should send :timeout msg to :test process"
  end
end
