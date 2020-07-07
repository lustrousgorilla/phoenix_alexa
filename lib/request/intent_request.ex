defmodule PhoenixAlexa.IntentRequest do
  alias PhoenixAlexa.Intent

  defstruct type: "IntentRequest",
            requestId: "",
            timestamp: "",
            intent: %Intent{}
end
