defmodule PhoenixAlexa.LinkAccountCard do
  alias PhoenixAlexa.LinkAccountCard

  defstruct type: "LinkAccount",
            title: "",
            content: ""

  def set_title(card, title) do
    %LinkAccountCard{card | title: title}
  end

  def set_content(card, content) do
    %LinkAccountCard{card | content: content}
  end
end
