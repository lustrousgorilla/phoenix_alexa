defmodule PhoenixAlexa.Request do
  alias PhoenixAlexa.{Session, GenericRequest}

  defstruct version: "",
            session: %Session{},
            request: %GenericRequest{}
end
