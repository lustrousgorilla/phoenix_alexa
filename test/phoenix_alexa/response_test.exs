defmodule PhoenixAlexa.ResponseTest do
  use ExUnit.Case
  alias PhoenixAlexa.{Response, TextOutputSpeech, SsmlOutputSpeech}
  alias PhoenixAlexa.{SimpleCard, StandardCard, LinkAccountCard}
  import PhoenixAlexa.Response

  test "empty response" do
    response =
      %Response{}
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_output_speech with TextOutputSpeech" do
    response =
      %Response{}
      |> set_output_speech(%TextOutputSpeech{text: "Say hello"})
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "outputSpeech" => %{
                 "text" => "Say hello",
                 "type" => "PlainText"
               },
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_output_speech with SsmlOutputSpeech" do
    response =
      %Response{}
      |> set_output_speech(%SsmlOutputSpeech{ssml: "<speak>This output speech uses SSML.</speak>"})
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "outputSpeech" => %{
                 "ssml" => "<speak>This output speech uses SSML.</speak>",
                 "type" => "SSML"
               },
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_card with SimpleCard" do
    card =
      %SimpleCard{}
      |> set_title("Title")
      |> set_content("Content")

    response =
      %Response{}
      |> set_card(card)
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "card" => %{
                 "content" => "Content",
                 "title" => "Title",
                 "type" => "Simple"
               },
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_card with StandardCard" do
    card =
      %StandardCard{}
      |> set_title("Title")
      |> set_text("Text")
      |> set_small_image_url("http://small_image_url")
      |> set_large_image_url("http://large_image_url")

    response =
      %Response{}
      |> set_card(card)
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "card" => %{
                 "image" => %{
                   "smallImageUrl" => "http://small_image_url",
                   "largeImageUrl" => "http://large_image_url"
                 },
                 "text" => "Text",
                 "title" => "Title",
                 "type" => "Standard"
               },
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_card with StandardCard no images" do
    card =
      %StandardCard{}
      |> set_title("Title")
      |> set_text("Text")

    response =
      %Response{}
      |> set_card(card)
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "card" => %{
                 "text" => "Text",
                 "title" => "Title",
                 "type" => "Standard"
               },
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_card with LinkAccountCard" do
    card =
      %LinkAccountCard{}
      |> set_title("Title")
      |> set_content("Content")

    response =
      %Response{}
      |> set_card(card)
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "card" => %{
                 "content" => "Content",
                 "title" => "Title",
                 "type" => "LinkAccount"
               },
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_reprompt with TextOutputSpeech" do
    response =
      %Response{}
      |> set_reprompt(%TextOutputSpeech{text: "Say hello"})
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "reprompt" => %{
                 "outputSpeech" => %{
                   "text" => "Say hello",
                   "type" => "PlainText"
                 }
               },
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_reprompt with SsmlOutputSpeech" do
    response =
      %Response{}
      |> set_reprompt(%SsmlOutputSpeech{ssml: "<speak>This output speech uses SSML.</speak>"})
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "reprompt" => %{
                 "outputSpeech" => %{
                   "ssml" => "<speak>This output speech uses SSML.</speak>",
                   "type" => "SSML"
                 }
               },
               "shouldEndSession" => false
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end

  test "set_should_end_session" do
    response =
      %Response{}
      |> set_should_end_session(true)
      |> Poison.encode!()
      |> Poison.decode!()

    assert response == %{
             "response" => %{
               "shouldEndSession" => true
             },
             "sessionAttributes" => %{},
             "version" => "1.0"
           }
  end
end
