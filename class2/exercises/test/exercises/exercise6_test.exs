defmodule Exercises.Exercise6Test do
  use ExUnit.Case, async: false

  @tag :test6
  test "Test 6" do
    Process.register(self(), :test)
    Exercises.Exercise6.process_monitor()
    Process.sleep(100)
    pid_hello = Process.whereis(:hello)
    pid_world = Process.whereis(:world)
    assert pid_hello != nil, "Process :hello should be started"
    assert pid_world != nil, "Process :world should be started"

    assert Process.info(pid_hello, :monitored_by) == {:monitored_by, [pid_world]},
           "Process :hello should be monitored by process :world"

    assert {:monitors, [process: {:hello, _}]} = Process.info(pid_world, :monitors),
           "Process :world should monitor process :hello"

    Process.sleep(2000)
    assert Process.alive?(pid_hello) == false, "Process :hello should be terminated"
    assert Process.alive?(pid_world) == true, "Process :world should be alive"

    assert_receive {:DOWN, _, :process, _, _},
                   1000,
                   "Process :world should pass {:DOWN, ...} message to :test process"

    Process.sleep(1000)
  end
end
