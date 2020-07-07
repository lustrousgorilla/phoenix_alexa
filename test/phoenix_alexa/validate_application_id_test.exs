defmodule PhoenixAlexa.ValidateApplicationIdTest do
  use ExUnit.Case
  use Plug.Test

  alias PhoenixAlexa.ValidateApplicationId

  test "valid application id" do
    conn =
      conn(:post, "/alexa", "%{}")
      |> Map.put(:body_params, %{
        "session" => %{
          "application" => %{"applicationId" => "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"}
        }
      })

    options = ValidateApplicationId.init("amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a")
    assert conn == ValidateApplicationId.call(conn, options)
  end

  test "invalid application id" do
    conn =
      conn(:post, "/alexa", "%{}")
      |> Map.put(:body_params, %{"session" => %{"application" => %{"applicationId" => "__invalid_application_id__"}}})

    options = ValidateApplicationId.init("amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a")
    conn = ValidateApplicationId.call(conn, options)
    assert conn.state == :sent
    assert conn.status == 400
    assert conn.resp_body == ~s({"error": "Invalid application"})
    assert conn.halted
  end
end
