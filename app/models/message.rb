class Message < ActiveRecord::Base
  belongs_to :users
  belongs_to :tutors
  
  validates_presence_of :body, :user_id, :recipient_id
  validate :sender_and_recipient_differ
  
  private
    def sender_and_recipient_differ
      if self.user_id == self.recipient_id
        errors.add(:base, "Sender and recipient cannot be the same.")
      end
    end
end
