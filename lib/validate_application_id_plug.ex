defmodule PhoenixAlexa.ValidateApplicationId do
  import Plug.Conn

  def init(applicationId), do: applicationId

  def call(conn, applicationId) do
    case conn.body_params["session"]["application"]["applicationId"] do
      ^applicationId ->
        conn

      _ ->
        conn
        |> Plug.Conn.send_resp(400, ~s({"error": "Invalid application"}))
        |> halt
    end
  end
end
