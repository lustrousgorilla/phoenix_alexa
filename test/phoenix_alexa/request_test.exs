defmodule PhoenixAlexa.RequestTest do
  use ExUnit.Case

  alias PhoenixAlexa.{Session, IntentRequest}

  test "session" do
    json_session = """
    {
      "new": false,
      "sessionId": "amzn1.echo-api.session.0000000-0000-0000-0000-00000000000",
      "application": {
        "applicationId": "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"
      },
      "attributes": {
        "supportedHoroscopePeriods": {
          "daily": true,
          "weekly": false,
          "monthly": false
        }
      },
      "user": {
        "userId": "amzn1.account.AM3B00000000000000000000000"
      }
    }
    """

    session = Poison.decode!(json_session, as: %Session{})

    assert session.new == false
    assert session.sessionId == "amzn1.echo-api.session.0000000-0000-0000-0000-00000000000"
    assert session.application.applicationId == "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"

    assert session.attributes == %{
             "supportedHoroscopePeriods" => %{
               "daily" => true,
               "weekly" => false,
               "monthly" => false
             }
           }

    assert session.user.userId == "amzn1.account.AM3B00000000000000000000000"
  end

  test "request" do
    json_request = """
    {
      "type": "IntentRequest",
      "requestId": "amzn1.echo-api.request.0000000-0000-0000-0000-00000000000",
      "timestamp": "2015-05-13T12:34:56Z",
      "intent": {
        "name": "GetZodiacHoroscopeIntent",
        "slots": {
          "ZodiacSign": {
            "name": "ZodiacSign",
            "value": "virgo"
          }
        }
      }
    }
    """

    request = Poison.decode!(json_request, as: %IntentRequest{})

    assert request.type == "IntentRequest"
    assert request.requestId == "amzn1.echo-api.request.0000000-0000-0000-0000-00000000000"
    assert request.timestamp == "2015-05-13T12:34:56Z"
    assert request.intent.name == "GetZodiacHoroscopeIntent"
    assert request.intent.slots["ZodiacSign"]["name"] == "ZodiacSign"
    assert request.intent.slots["ZodiacSign"]["value"] == "virgo"
  end
end

# {
#   "version": "1.0",
#   "session": {
#     "new": false,
#     "sessionId": "amzn1.echo-api.session.0000000-0000-0000-0000-00000000000",
#     "application": {
#       "applicationId": "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"
#     },
#     "attributes": {
#       "supportedHoroscopePeriods": {
#         "daily": true,
#         "weekly": false,
#         "monthly": false
#       }
#     },
#     "user": {
#       "userId": "amzn1.account.AM3B00000000000000000000000"
#     }
#   },
#   "request": {
# "type": "IntentRequest",
# "requestId": " amzn1.echo-api.request.0000000-0000-0000-0000-00000000000",
# "timestamp": "2015-05-13T12:34:56Z",
# "intent": {
#   "name": "GetZodiacHoroscopeIntent",
#   "slots": {
#     "ZodiacSign": {
#       "name": "ZodiacSign",
#       "value": "virgo"
#     }
#   }
# }
#   }
# }
