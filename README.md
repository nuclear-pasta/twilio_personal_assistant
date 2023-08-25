# Twilio AI Assistant with Voice Cloning

## Overview

This application serves as a bridge between traditional phone calls and modern AI capabilities. When a user makes a phone call, the application redirects the call to an AI assistant powered by OpenAI's ChatGPT. This assistant engages in a conversation with the caller, generating human-like text responses based on the ongoing conversation. All interactions during the call, including the messages exchanged, are stored for reference.

## Prototype Disclaimer

It's important to note that this application currently stands as a prototype, a proof of concept showcasing the potential of integrating voice-based AI into traditional phone calls. While the foundation and functionalities are in place, the current version experiences significant latency in the audio generation process, making real-time interactions challenging. This latency, although a limitation in this prototype, serves as a testament to the possibilities ahead. As technologies and integrations evolve, future iterations aim to overcome this challenge, paving the way for seamless and real-time AI-powered voice interactions.

## Features

1. **Twilio Integration**: Allows users to make and receive calls.
2. **Voice Cloning with Eleven Labs**: Converts text to speech with a specific voice.
3. **AI Assistant with OpenAI**: Provides AI assistant functionality using OpenAI's GPT-3.5-turbo model.

## Controllers

### TwilioController

- `create`: Handles incoming calls, processes speech results, and responds with either an AI assistant message or a goodbye message.
- `index`: Default endpoint for incoming calls.
- `make_call`: Test endpoint to initiate a call.

### InboxController

- `index`: Lists all conversations.
- `show`: Displays messages for a specific conversation.

## Services

### VoiceCloner

- Uses the Eleven Labs API to convert text to speech.
- Requires `ELEVEN_LABS_TOKEN` and `ELEVENT_LABS_VOICE_ID` environment variables.
- **Note**: The `ELEVENT_LABS_VOICE_ID` needs to be created from the UI on the Eleven Labs website by training it with audio messages of the desired voice. Once trained, you can retrieve the `voice_id` and store it in an environment variable. The voice cloning process has inherent latency as it requires generating the audio, downloading it, and then sending the link.

### TwilioService

- Handles Twilio-related operations like generating speech responses and initiating calls.
- Requires `TWILIO_ACCOUNT_SID` and `TWILIO_AUTH_TOKEN` environment variables.
- **Note**: Twilio provides a robotic speech-to-text feature that can be used for faster conversations without the need for voice cloning.

### ChatService (AI Assistant Service)

- Uses OpenAI's GPT-3.5-turbo model to generate AI assistant responses.
- Requires `OPEN_AI_TOKEN` environment variable.

## Setup

1. Ensure you have the required environment variables set:
   - `NGROK_URL`
   - `FROM_NUMBER` needs to be Twilio purchased Number
   - `TO_NUMBER`needs to be Twilio Verified Number
   - `ELEVEN_LABS_TOKEN`
   - `ELEVENT_LABS_VOICE_ID`
   - `TWILIO_ACCOUNT_SID`
   - `TWILIO_AUTH_TOKEN`
   - `OPEN_AI_TOKEN`

2. Run the ngrok command: ngrok http 3000. This will expose your local server to the internet. Copy the generated URL and store it in the `NGROK_URL` environment variable.

3. Install required gems: bundle install

4. Run the application: rails server

5. Use the `make_call` endpoint to test the call functionality.

6. Configure your Twilio webhook: Navigate to [Twilio's Console](https://console.twilio.com/us1/develop/phone-numbers/manage/incoming) and set the webhook for the active number to the URL you stored in `NGROK_URL` followed by `/messages`. Any incoming call to the registered number will be redirected to the `index` action of `TwilioController`.

## Views

### Inbox

- `GET /inbox`: Lists all conversations.
- `GET /inbox/:id`: Displays messages for a specific conversation.

## Notes

- Ensure you have the required gems installed, such as `twilio-ruby`, `httparty`, and `openai`.
- The application assumes you have an ngrok setup for local development to expose your local server to the internet.
- The `voice_cloner_enabled` config determines if the voice cloning feature is enabled.

## Loom Demo

https://www.loom.com/share/94ae1e58309c48a3a521adeca98feaf7

## Future Intentions

1. **Integration with Google Calendar**: This will allow the AI assistant to schedule, reschedule, or cancel appointments based on the conversation with the user.
2. **User Input on Tasks**: Enhance the AI assistant's capabilities by allowing users to define specific tasks. For instance, a user could instruct the assistant with a task like "book a barbershop appointment", and the assistant would handle the rest, potentially even making calls on behalf of the user to fulfill such requests.
3. **WebSocket for Speed**: To further optimize the user experience, I'm exploring the integration of WebSockets to expedite audio generation. However, a notable challenge is that Twilio's WebSocket service doesn't natively support their transcript service. This means I'll be diving into integrating a separate transcription service to ensure seamless functionality.


