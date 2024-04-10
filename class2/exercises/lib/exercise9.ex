defmodule Exercises.Exercise9 do
  @doc """
    Spawn :server process, which endlessly handles messages.
    Sever should pass messages to :test process.
    When server gets exit singal, then it should send :handle_exit message to :test process.
    Server should send :timeout message to :test process after 500ms inactivity.
    Spawn :client process which sends to server 10 messages
  """
  def server() do
    # write your code here
  end
end
