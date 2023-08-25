# frozen_string_literal: true

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  NGROK_URL = ENV['NGROK_URL']
  def create
    if params['SpeechResult']
      asr_message = params['SpeechResult']
      asr_caller = params['Caller']
      call_sid = params['CallSid']
      conversation = Conversation.find_or_create_by(call_sid: call_sid)
      Message.create(caller: asr_caller, body: asr_message, call_sid: call_sid, conversation: conversation)
      if asr_message.downcase.include?('stop')
        @speech = TwilioService.new.say_goodbye
        render xml: @speech
      else
        text = ChatService.new.get_chat_response(conversation.reload.messages)
        message = Message.create(caller: 'system', body: text, call_sid: call_sid, conversation: conversation)
        if Rails.application.config.voice_cloner_enabled
          audio = VoiceCloner.new.get_voice_from_text(text) 
          message.audio = audio
          message.save
          audio_url = "#{NGROK_URL}/#{message.reload.audio.url}"
        end
        @speech = TwilioService.new.get_speech(reply: message.body, audio_url: audio_url)
        render xml: @speech
      end
    end
  end

  def index
    @speech = TwilioService.new.get_speech
    render xml: @speech
  end

  #TEST ENDPOINT TO MAKE CALL
  def make_call
    from_number = ENV['FROM_NUMBER'] # Your Twilio phone number
    to_number = ENV['TO_NUMBER']  # The phone number you want to call
    url = "#{NGROK_URL}/twilio/index"
    TwilioService.new.make_call(from_number, to_number, url)
    render plain: 'Call initiated'
  end
end
