defmodule PhoenixAlexa.GenericRequest do
  alias PhoenixAlexa.Intent

  defstruct type: nil,
            requestId: nil,
            timestamp: nil,
            reason: nil,
            intent: %Intent{}
end
