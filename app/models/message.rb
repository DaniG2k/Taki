class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :tutor
  
  validates_presence_of :body, :user_id, :tutor_id
end
