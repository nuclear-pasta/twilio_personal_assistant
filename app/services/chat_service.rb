# app/services/chat_service.rb
class ChatService
    def initialize
      @client = OpenAI::Client.new(access_token: ENV['OPEN_AI_TOKEN'])
      @task = "take messages for me" # You can replace this with any other task you'd like to achieve.

    end
  
    def get_chat_response(conversation)

      messages = [{ role: 'system', content: "You are a Dario's human personal assistant called Francisco. You do not have any AI abilities. Your task is to #{@task}. You need to have a conversation with the user and try to achieve the task in a polite and human-like manner." }]
      messages += conversation.map { |message| { role: message.sender_role, content: message.body }}
      response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: messages, # Required.
          temperature: 0.7
        }
      )

     response.dig("choices", 0, "message", "content")
  
    end

  end
  