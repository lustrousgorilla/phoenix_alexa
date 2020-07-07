defmodule PhoenixAlexa.StandardCard do
  alias PhoenixAlexa.StandardCard

  defstruct type: "Standard",
            title: "",
            text: ""

  def set_title(card, title) do
    %StandardCard{card | title: title}
  end

  def set_text(card, text) do
    %StandardCard{card | text: text}
  end

  def set_small_image_url(card, image_url) do
    image = Map.get(card, :image) || %{}
    image = Map.put(image, :smallImageUrl, image_url)
    Map.put(card, :image, image)
  end

  def set_large_image_url(card, image_url) do
    image = Map.get(card, :image) || %{}
    image = Map.put(image, :largeImageUrl, image_url)
    Map.put(card, :image, image)
  end
end
