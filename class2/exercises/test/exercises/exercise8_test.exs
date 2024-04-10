defmodule Exercises.Exercise8Test do
  use ExUnit.Case, async: false

  @tag :test8
  test "Test 8" do
    Process.register(self(), :test)
    Exercises.Exercise8.process_link()
    Process.sleep(100)
    pid_hello = Process.whereis(:hello)
    pid_world = Process.whereis(:world)
    assert pid_hello != nil, "Process :hello should be started"
    assert pid_world != nil, "Process :world should be started"

    assert Process.info(pid_hello, :links) == {:links, [pid_world]},
           "Process :hello should be linked with :world process"

    assert Process.info(pid_world, :links) == {:links, [pid_hello]},
           "Process :world should be linked with :hello process"

    Process.sleep(2000)
    assert Process.alive?(pid_hello) == false, "Process :hello should be terminated"
    assert Process.alive?(pid_world) == true, "Process :world should be alive"

    assert_receive {:EXIT, pid_hello, _},
                   100,
                   "Process :world should pass {:EXIT, ...} message to :test process"
  end
end
