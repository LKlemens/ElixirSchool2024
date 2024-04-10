defmodule Exercises.Exercise7Test do
  use ExUnit.Case, async: false

  @tag :test7
  test "Test 7" do
    Process.register(self(), :test)
    Exercises.Exercise7.process_link()
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
    assert Process.alive?(pid_world) == false, "Process :world should be terminated"
  end
end
