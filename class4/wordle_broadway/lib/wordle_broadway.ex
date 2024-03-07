defmodule WordleBroadway do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: WordleBroadway,
      producer: [
        module:
          {BroadwayRabbitMQ.Producer,
           queue: "my_queue",
           on_failure: :reject,
           connection: [
             host: "localhost",
             port: 5672,
             username: "test",
             password: "test"
           ],
           qos: [
             prefetch_count: 1
           ]},
        concurrency: 7
      ],
      processors: [
        default: [
          concurrency: 5
        ]
      ],
      batchers: [
        default: [
          batch_size: 4,
          batch_timeout: 3000,
          concurrency: 5
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    message
    # TODO add data processing
    |> Message.update_data(fn data -> data end)
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    list = messages |> Enum.map(fn e -> e.data end)
    IO.inspect(list, label: "Got batch")
    messages
  end
end
