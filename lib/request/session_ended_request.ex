defmodule PhoenixAlexa.SessionEndedRequest do
  defstruct type: "SessionEndedRequest",
            requestId: nil,
            timestamp: nil,
            reason: nil
end
