defmodule Exercises.Exercise9 do
  @doc """
    Spawn :server process - process which endlessly handles messages.
    Sever should pass messages to :test process .
    When server gets exit singal, then it should send :handle_exit message to :test process.
    Server should send :nothing_todo message to :test process after 500ms inactivity.
    Spawn :client process which sends to server 10 messages
  """
  def server() do
    server_pid =
      spawn(fn ->
        Process.flag(:trap_exit, true)
        loop()
      end)

    Process.register(server_pid, :server)

    spawn(fn ->
      Enum.each(1..10, fn i ->
        send(:server, i)
      end)
    end)
  end

  defp loop() do
    receive do
      {:EXIT, _, _} ->
        IO.inspect("handle exit msg")
        send(:test, :handle_exit)

      msg ->
        IO.inspect(msg, label: "handle msg")
        send(:test, msg)
    after
      500 ->
        send(:test, :nothing_todo)
    end

    loop()
  end
end
