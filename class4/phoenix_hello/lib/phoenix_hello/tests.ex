defmodule PhoenixHello.Tests do
  alias PhoenixHello.Receiver

  def exercise1() do
    [node | _rest] = Node.list()
    {"hello", ^node} = Receiver.send_msg("hello")
  end

  def exercise2() do
    number_of_nodes = length(Node.list()) + 1
    responses = Receiver.send_msg_to_all_nodes("hello")

    Enum.each(responses, fn response ->
      {"hello", _} = response
    end)

    ^number_of_nodes = length(responses)
    responses
  end
end
