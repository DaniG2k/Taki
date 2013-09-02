class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :tutor, class_name: "Tutor", foreign_key: "recipient_id"
  
  validates_presence_of :body, :user_id, :recipient_id
  validate :sender_and_recipient_differ
end
