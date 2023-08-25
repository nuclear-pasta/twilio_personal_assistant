class Conversation < ApplicationRecord
    has_many :messages
    validates :call_sid, uniqueness: true
end
