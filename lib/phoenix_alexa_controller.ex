defmodule PhoenixAlexa.Controller do
  # https://developer.amazon.com/docs/custom-skills/request-and-response-json-reference.html
  # https://developer.amazon.com/en-US/docs/alexa/custom-skills/understand-name-free-interaction-for-custom-skills.html
  # https://developer.amazon.com/en-US/docs/alexa/custom-skills/implement-canfulfillintentrequest-for-name-free-interaction.html

  defmacro __using__(method) do
    quote do
      import PhoenixAlexa.{Controller, Response}
      alias PhoenixAlexa.{Request, Response, Intent, TextOutputSpeech, SsmlOutputSpeech, CanFulfillIntent}
      alias PhoenixAlexa.{SimpleCard, StandardCard, LinkAccountCard}

      def set_response(conn, status \\ 200, response) do
        conn
          |> Plug.Conn.put_resp_content_type("application/json")
          |> Plug.Conn.resp(status, Poison.encode!(response))
      end

      def handle_request(conn, request) do
        case request.request.type do
          "LaunchRequest" ->
            launch_request(conn, request)
          "IntentRequest" ->
            intent_request(conn, request.request.intent.name, request)
          "CanFulfillIntentRequest" ->
            can_fulfill_intent_request(conn, request.request.intent.name, request.request.intent.slots, request)
          "SessionEndedRequest" ->
            session_ended_request(conn, request)
              |> set_response(%{})
        end
          |> Plug.Conn.send_resp()
      end

      def unquote(method)(conn, params) do
        case Poison.Decode.decode(params, as: %PhoenixAlexa.Request{}) do
          %PhoenixAlexa.Request{} = request -> handle_request(conn, request)
          _ ->
            conn
              |> Plug.Conn.put_resp_content_type("application/json")
              |> Plug.Conn.send_resp(500, Poison.encode!(%{error: "Internal Error"}))
        end

      end

      def launch_request(conn, _request) do
        conn |> set_response(%Response{})
      end

      def session_ended_request(conn, request) do
        conn
      end

      def can_fulfill_intent_request(conn, intent, _request) do
        conn |> set_response(%Response{})
      end

      def intent_request(conn, _, request) do
        conn |> set_response(%Response{})
      end

      defoverridable [launch_request: 2, intent_request: 3, can_fulfill_intent_request: 3,
                      session_ended_request: 2]

    end
  end

end
