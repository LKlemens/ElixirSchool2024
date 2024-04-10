defmodule Exercises.Exercise9Test do
  use ExUnit.Case, async: false

  @tag :test9
  test "Test 9" do
    Process.register(self(), :test)
    Exercises.Exercise9.server()
    Process.sleep(100)
    pid_server = Process.whereis(:server)
    assert pid_server != nil, "Process :server should be started"

    Enum.each(1..10, fn _ ->
      assert_receive _, 100, "Process :test should get 10 messages from :server process"
    end)

    spawn(fn ->
      Process.link(pid_server)
      raise("error")
    end)

    assert_receive :handle_exit,
                   100,
                   "Process :test should get :handle_exit message from :server process"

    assert_receive :nothing_todo,
                   600,
                   "Process :test should get :nothing_todo message from :server process after 500ms inactivity"

    Process.sleep(500)
  end
end
