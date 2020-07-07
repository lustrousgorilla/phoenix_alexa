defmodule PhoenixAlexa.ControllerTest do
  use ExUnit.Case
  use Plug.Test

  defmodule HoroscopeController do
    use PhoenixAlexa.Controller, :post

    def launch_request(conn, request) do
      assert request.version == "1.0"
      assert request.session.new == false
      assert request.session.sessionId == "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f"
      assert request.session.application.applicationId == "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"
      assert request.session.attributes == %{}

      assert request.session.user.userId ==
               "amzn1.ask.account.AFP3ZWPOS2BGJR7OWJZ3DHPKMOMNWY4AY66FUR7ILBWANIHQN73QH3G5PC2FJVGDIDA7MY54GGNRGM4SVPKTT3K53SLI232MEFI77TZN7W6LISNFZTTFDSPCLX6OB4ISJDVJB6QZO3XC74US6CH5DQXYCVOODNTUFNI5JNSUWSBDVMWB7JXPVX43P4EUIMHTPZHNRHZDUDENZVI"

      assert request.request.type == "LaunchRequest"
      assert request.request.requestId == "EdwRequestId.27142539-8af4-430c-8f22-411cfab269bd"
      assert request.request.timestamp == "2016-07-07T00:45:08Z"

      response =
        %Response{}
        |> set_output_speech(%TextOutputSpeech{text: "Welcome to the Horoscope."})

      conn
      |> set_response(response)
    end

    def session_ended_request(conn, request) do
      assert request.version == "1.0"
      assert request.session.new == false
      assert request.session.sessionId == "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f"
      assert request.session.application.applicationId == "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"
      assert request.session.attributes == %{}

      assert request.session.user.userId ==
               "amzn1.ask.account.AFP3ZWPOS2BGJR7OWJZ3DHPKMOMNWY4AY66FUR7ILBWANIHQN73QH3G5PC2FJVGDIDA7MY54GGNRGM4SVPKTT3K53SLI232MEFI77TZN7W6LISNFZTTFDSPCLX6OB4ISJDVJB6QZO3XC74US6CH5DQXYCVOODNTUFNI5JNSUWSBDVMWB7JXPVX43P4EUIMHTPZHNRHZDUDENZVI"

      assert request.request.type == "SessionEndedRequest"
      assert request.request.requestId == "EdwRequestId.27142539-8af4-430c-8f22-411cfab269bd"
      assert request.request.timestamp == "2016-07-07T00:45:08Z"
      assert request.request.reason == "USER_INITIATED"

      conn
    end

    def intent_request(conn, "GetHoroscope", request) do
      assert request.version == "1.0"
      assert request.session.new == false
      assert request.session.sessionId == "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f"
      assert request.session.application.applicationId == "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"
      assert request.session.attributes == %{}

      assert request.session.user.userId ==
               "amzn1.ask.account.AFP3ZWPOS2BGJR7OWJZ3DHPKMOMNWY4AY66FUR7ILBWANIHQN73QH3G5PC2FJVGDIDA7MY54GGNRGM4SVPKTT3K53SLI232MEFI77TZN7W6LISNFZTTFDSPCLX6OB4ISJDVJB6QZO3XC74US6CH5DQXYCVOODNTUFNI5JNSUWSBDVMWB7JXPVX43P4EUIMHTPZHNRHZDUDENZVI"

      assert request.request.type == "IntentRequest"
      assert request.request.requestId == "EdwRequestId.27142539-8af4-430c-8f22-411cfab269bd"
      assert request.request.timestamp == "2016-07-07T00:45:08Z"
      assert request.request.intent.name == "GetHoroscope"
      assert request.request.intent.slots["Sign"]["name"] == "Sign"
      assert request.request.intent.slots["Sign"]["value"] == "Libra"
      assert request.request.intent.slots["Date"]["name"] == "Date"
      assert request.request.intent.slots["Date"]["value"] == nil

      card =
        %SimpleCard{}
        |> SimpleCard.set_title("Get Horoscope")
        |> SimpleCard.set_content("You are going to have an unexpected event today.")

      response =
        %Response{}
        |> set_output_speech(%TextOutputSpeech{text: "You are going to have an unexpected event today."})
        |> set_card(card)
        |> set_session_attributes(%{my_key: "my_data"})
        |> set_should_end_session(true)

      conn |> set_response(response)
    end

    def can_fulfill_intent_request(conn, "GetHoroscope", slots, _request) do
      slots =
        Enum.reduce(slots, %{}, fn {slot, _val}, acc ->
          Map.put(acc, slot, %{canUnderstand: "YES", canFulfill: "YES"})
        end)

      response =
        %Response{}
        |> set_can_fulfill_intent(%CanFulfillIntent{canFulfill: "YES", slots: slots})

      set_response(conn, response)
    end
  end

  test "LaunchRequest" do
    json = """
    {
      "session": {
        "sessionId": "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f",
        "application": {
          "applicationId": "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"
        },
        "attributes": {},
        "user": {
          "userId": "amzn1.ask.account.AFP3ZWPOS2BGJR7OWJZ3DHPKMOMNWY4AY66FUR7ILBWANIHQN73QH3G5PC2FJVGDIDA7MY54GGNRGM4SVPKTT3K53SLI232MEFI77TZN7W6LISNFZTTFDSPCLX6OB4ISJDVJB6QZO3XC74US6CH5DQXYCVOODNTUFNI5JNSUWSBDVMWB7JXPVX43P4EUIMHTPZHNRHZDUDENZVI"
        },
        "new": false
      },
      "request": {
        "type": "LaunchRequest",
        "requestId": "EdwRequestId.27142539-8af4-430c-8f22-411cfab269bd",
        "timestamp": "2016-07-07T00:45:08Z"
      },
      "version": "1.0"
    }
    """

    conn = conn(:post, "/alexa", "#{json}")

    conn = HoroscopeController.post(conn, Poison.decode!(json))
    response = Poison.decode!(conn.resp_body)

    expected_response = %{
      "version" => "1.0",
      "sessionAttributes" => %{},
      "response" => %{
        "outputSpeech" => %{
          "type" => "PlainText",
          "text" => "Welcome to the Horoscope."
        },
        "shouldEndSession" => false
      }
    }

    assert conn.status == 200
    assert response == expected_response
  end

  test "IntentRequest" do
    json = """
    {
      "session": {
        "sessionId": "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f",
        "application": {
          "applicationId": "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"
        },
        "attributes": {},
        "user": {
          "userId": "amzn1.ask.account.AFP3ZWPOS2BGJR7OWJZ3DHPKMOMNWY4AY66FUR7ILBWANIHQN73QH3G5PC2FJVGDIDA7MY54GGNRGM4SVPKTT3K53SLI232MEFI77TZN7W6LISNFZTTFDSPCLX6OB4ISJDVJB6QZO3XC74US6CH5DQXYCVOODNTUFNI5JNSUWSBDVMWB7JXPVX43P4EUIMHTPZHNRHZDUDENZVI"
        },
        "new": false
      },
      "request": {
        "type": "IntentRequest",
        "requestId": "EdwRequestId.27142539-8af4-430c-8f22-411cfab269bd",
        "timestamp": "2016-07-07T00:45:08Z",
        "intent": {
          "name": "GetHoroscope",
          "slots": {
            "Sign": {
              "name": "Sign",
              "value": "Libra"
            },
            "Date": {
              "name": "Date"
            }
          }
        },
        "locale": "en-US"
      },
      "version": "1.0"
    }
    """

    conn = conn(:post, "/alexa", "#{json}")

    conn = HoroscopeController.post(conn, Poison.decode!(json))

    response = Poison.decode!(conn.resp_body)

    expected_response = %{
      "version" => "1.0",
      "response" => %{
        "card" => %{
          "type" => "Simple",
          "title" => "Get Horoscope",
          "content" => "You are going to have an unexpected event today."
        },
        "outputSpeech" => %{
          "type" => "PlainText",
          "text" => "You are going to have an unexpected event today."
        },
        "shouldEndSession" => true
      },
      "sessionAttributes" => %{"my_key" => "my_data"}
    }

    assert conn.status == 200
    assert response == expected_response
  end

  test "CanFulfillIntentRequest" do
    json = """
    {
      "session": {
        "sessionId": "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f",
        "application": {
          "applicationId": "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"
        },
        "attributes": {},
        "user": {
          "userId": "amzn1.ask.account.AFP3ZWPOS2BGJR7OWJZ3DHPKMOMNWY4AY66FUR7ILBWANIHQN73QH3G5PC2FJVGDIDA7MY54GGNRGM4SVPKTT3K53SLI232MEFI77TZN7W6LISNFZTTFDSPCLX6OB4ISJDVJB6QZO3XC74US6CH5DQXYCVOODNTUFNI5JNSUWSBDVMWB7JXPVX43P4EUIMHTPZHNRHZDUDENZVI"
        },
        "new": false
      },
      "request": {
        "type": "CanFulfillIntentRequest",
        "requestId": "EdwRequestId.27142539-8af4-430c-8f22-411cfab269bd",
        "timestamp": "2016-07-07T00:45:08Z",
        "intent": {
          "name": "GetHoroscope",
          "slots": {
            "Sign": {
              "name": "Sign",
              "value": "Libra"
            },
            "Date": {
              "name": "Date"
            }
          }
        },
        "locale": "en-US"
      },
      "version": "1.0"
    }
    """

    conn = conn(:post, "/alexa", "#{json}")

    conn = HoroscopeController.post(conn, Poison.decode!(json))

    response = Poison.decode!(conn.resp_body)

    expected_response = %{
      "version" => "1.0",
      "response" => %{
        "canFulfillIntent" => %{
          "canFulfill" => "YES",
          "slots" => %{
            "Sign" => %{
              "canUnderstand" => "YES",
              "canFulfill" => "YES"
            },
            "Date" => %{
              "canUnderstand" => "YES",
              "canFulfill" => "YES"
            }
          }
        },
        "shouldEndSession" => false
      },
      "sessionAttributes" => %{}
    }

    assert conn.status == 200
    assert response == expected_response
  end

  test "SessionEndedRequest" do
    json = """
    {
      "session": {
        "sessionId": "SessionId.80ef8951-172e-4f02-ace8-a7ec847e2d9f",
        "application": {
          "applicationId": "amzn1.echo-sdk-ams.app.05dcb1a4-cb45-46c5-a30e-bb3033a0770a"
        },
        "attributes": {},
        "user": {
          "userId": "amzn1.ask.account.AFP3ZWPOS2BGJR7OWJZ3DHPKMOMNWY4AY66FUR7ILBWANIHQN73QH3G5PC2FJVGDIDA7MY54GGNRGM4SVPKTT3K53SLI232MEFI77TZN7W6LISNFZTTFDSPCLX6OB4ISJDVJB6QZO3XC74US6CH5DQXYCVOODNTUFNI5JNSUWSBDVMWB7JXPVX43P4EUIMHTPZHNRHZDUDENZVI"
        },
        "new": false
      },
      "request": {
        "type": "SessionEndedRequest",
        "requestId": "EdwRequestId.27142539-8af4-430c-8f22-411cfab269bd",
        "timestamp": "2016-07-07T00:45:08Z",
        "reason": "USER_INITIATED"
      },
      "version": "1.0"
    }
    """

    conn = conn(:post, "/alexa", "#{json}")

    conn = HoroscopeController.post(conn, Poison.decode!(json))
    response = Poison.decode!(conn.resp_body)

    expected_response = %{}

    assert conn.status == 200
    assert response == expected_response
  end
end
