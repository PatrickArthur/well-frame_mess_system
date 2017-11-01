class Message < ActiveRecord::Base
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :conversation
  validates_presence_of :message_text, :conversation_id, :sender_id
end
