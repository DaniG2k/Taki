class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
end
