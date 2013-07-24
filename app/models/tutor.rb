class Tutor < ActiveRecord::Base
  belongs_to :user
  has_many :students
  
  validates :description, presence: true
  validates :description, length: { maximum: 800 }
end
