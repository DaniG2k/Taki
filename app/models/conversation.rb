class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates_presence_of :sender_id, :recipient_id
end
