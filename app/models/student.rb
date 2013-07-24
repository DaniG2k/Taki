class Student < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tutors
  
  validates :description, presence: true
  validates :description, length: { maximum: 800 }
end
