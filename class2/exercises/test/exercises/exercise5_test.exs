defmodule Exercises.Exercise5Test do
  use ExUnit.Case, async: false

  @tag :test5
  test "Test 5" do
    Process.register(self(), :test)
    pid = Exercises.Exercise5.selective_receive()
    assert is_pid(pid) == true, "Function should return pid"
    Process.sleep(200)
    IO.inspect("send first")
    send(:hello, :first)
    Process.sleep(200)
    IO.inspect("send second")
    send(:hello, :second)

    assert_receive :second,
                   1000,
                   "Process :hello should send :second msg to :test process as first message"

    assert_receive :first,
                   1000,
                   "Process :hello should send :first msg to :test process as second message"
  end
end
