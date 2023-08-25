class TwilioService
    def initialize
        @response = Twilio::TwiML::VoiceResponse.new
        @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    end
  
    def get_speech(reply: nil, audio_url: nil)
        message = reply || 'You will soon be redirected to chat with an AI, be patient, it is still learning and the latency between your message and an answer can still be longer than a normal human conversation. Can you tell me why you called?'
        @response.gather(input: 'speech', timeout: 3, action: '/messages', method: 'POST') do |gather|
            if Rails.application.config.voice_cloner_enabled && audio_url
                gather.play(url: audio_url)
            else
                gather.say(message)
            end
        end
    end
  
    def say_goodbye
        @response.say('Thank you, this call will now end')
        @response.hangup
    end

    def make_call(from_number, to_number, url)
        call = @client.calls.create(
                            url: url,
                            to: to_number,
                            from: from_number
                            )
        
      end
  end