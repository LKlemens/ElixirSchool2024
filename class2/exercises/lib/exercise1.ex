defmodule Exercises.Exercise1 do
  @doc """
   Spawn a process and send :pong to :ping process
    input: none
    returns: pid
  """
  def send_to_pong() do
    spawn(fn ->
      send(:ping, :pong)
    end)
  end
end
