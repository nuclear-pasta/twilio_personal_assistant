class VoiceCloner
    def initialize
        @token = ENV['ELEVEN_LABS_TOKEN']
        @voice_id = ENV['ELEVENT_LABS_VOICE_ID']
    end

    include HTTParty
    base_uri 'https://api.elevenlabs.io'

    def get_voice_from_text(text)
        @text = text
        response = self.class.post("/v1/text-to-speech/#{@voice_id}?optimize_streaming_latency=0", headers: headers, body: body)
        temp_file = Tempfile.new(["audio", ".mp3"])
        temp_file.binmode
        temp_file.write(response.body)
        temp_file.rewind
        temp_file
    end

    private

    def headers
        {
            "xi-api-key": @token,
            "Accept": "audio/mpeg",
            "Content-Type": "application/json"
        }
    end

    def body
        {
            "text": @text,
            "model_id": "eleven_monolingual_v1",
            "voice_settings": {
                "stability": 0.26,
                "similarity_boost": 0.75,
                "style": 0.5,
                "use_speaker_boost": true
            }
        }.to_json
    end

end