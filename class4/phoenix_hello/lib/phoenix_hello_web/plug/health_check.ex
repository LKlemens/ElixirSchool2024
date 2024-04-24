defmodule PhoenixHelloWeb.Plug.HealthCheck do
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{request_path: "/healthcheck"} = conn, _opts) do
    conn
    |> delete_resp_header("cache-control")
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "{\"status\":\"ok\"}")
    |> halt()
  end

  def call(conn, _opts), do: conn
end
