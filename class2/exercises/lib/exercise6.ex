defmodule Exercises.Exercise6 do
  @doc """
   - Spawn a new process, 
     - register it under :world name, 
     - start monitoring :hello process by :world process, 
     - after 1 second send :bad_msg to :hello process
     - wait for down msg from :hello process and send it to :test process
     - wait for next message
   - spawn a new unregistered process, 
      - wait 1500ms 
      - print ":world is alive!" if process :world is alive
      - print ":world is dead!" otherwise
   input: none
   returns: pid
  """
  def process_monitor() do
    pid =
      spawn(fn ->
        receive do
          :bad_msg -> raise("error")
          :die_normally -> :ok
        end
      end)

    Process.register(pid, :hello)

    # write here your code
  end
end
