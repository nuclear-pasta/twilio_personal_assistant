class Message < ApplicationRecord
    mount_uploader :audio, AudioUploader
    belongs_to :conversation
    def sender_role
        caller == "system" ? "system" : "user"
    end
end
