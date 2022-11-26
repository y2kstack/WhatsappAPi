require "httparty"
require 'uri'



TOKEN = ""
SENDER_ID = "100137039608242"
BUSINESS_ID = "107766202165397"
RECIPIENT_ID = "919480888784"
BASE_URL = "https://graph.facebook.com/v15.0/" + SENDER_ID + "/messages"


#  
# curl -i -X POST \
#   https://graph.facebook.com/v15.0/100137039608242/messages \
#   -H 'Authorization: Bearer EABPGZAbtGoYYBAK6rhu7qX9TAnPMYhEC77bUBMzdGMFJwzhn5jUjpyxTlE9rsUJk7RyaDVWHZABVNDXYjrXQ4bsLFki6PQcZA0y9n5kdZBcbVzdxGadHIVdZAsDlmCfge9BW9Nl0C81v768oB9S4X5FNDDb4EVQ17ZA6b6dfQQz1AtwzNjjkztZBfhQai4c9CcbxS3kmysz2bQ3oLwyX1NA28SC6n5D0EsZD' \
#   -H 'Content-Type: application/json' \
#   -d '{ "messaging_product": "whatsapp", "to": "919480888784", "type": "template", "template": { "name": "hello_world", "language": { "code": "en_US" } } }'

# URL = "#{BASE_URL}/oauth2/token"


class WhatsAppAPi
    include HTTParty

    def initialize

        data = {
            "messaging_product": "whatsapp",
            "to": "919480888784",
            "type": "template",
            "template": {
                "name": "hello_world",
                "language": {
                    "code": "en_US"
                }
            }
        }

        response = self.class.post(BASE_URL,
            body: (data),
            headers: {
                "Content-Type"  => "application/json" ,
              'Authorization' => "Bearer #{TOKEN}"
            }

          )

          @response_body = JSON.parse(response.body)
          raise @response_body["error_description"] if @response_body["error"]
          
          @contacts = @response_body["contacts"]
          @messages = @response_body["messages"]
    end

    def details
		{
			access_token: @access_token,
			contacs: @contacts,
            messages: @messages
		}
	end
end


whatsapi = WhatsAppAPi.new

puts "===#{__LINE__} --- #{__FILE__}==="

p whatsapi.details

