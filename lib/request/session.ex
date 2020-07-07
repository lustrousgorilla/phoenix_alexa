defmodule PhoenixAlexa.Session do
  alias PhoenixAlexa.{Application, User}

  defstruct new: false,
            sessionId: "",
            application: %Application{},
            attributes: nil,
            user: %User{}
end
