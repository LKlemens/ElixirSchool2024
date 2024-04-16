defmodule Exercises.Exercise6 do
  @doc """
   - Spawn a new process, 
     - register it under :world name, 
     - start monitoring :hello process by :world process, 
     - after 1 second send :bad_msg to :hello process
     - wait for down msg from :hello process
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

    world_pid =
      spawn(fn ->
        Process.register(self(), :world)
        Process.monitor(:hello)
        Process.sleep(1000)
        send(:hello, :bad_msg)

        receive do
          msg ->
            IO.inspect(msg, label: "down message")
            send(:test, msg)
        end

        # wait for next message
        receive do
          msg ->
            msg
        end
      end)

    spawn(fn ->
      Process.sleep(1500)

      if Process.alive?(world_pid) do
        IO.inspect(":world is alive!")
      else
        IO.inspect(":world is dead!")
      end
    end)
  end
end
