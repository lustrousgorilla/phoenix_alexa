defmodule PhoenixAlexa.SimpleCard do
  alias PhoenixAlexa.SimpleCard

  defstruct type: "Simple",
            title: "",
            content: ""

  def set_title(card, title) do
    %SimpleCard{card | title: title}
  end

  def set_content(card, content) do
    %SimpleCard{card | content: content}
  end
end
