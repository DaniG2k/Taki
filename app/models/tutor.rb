class Tutor < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :rate, greater_than: 0
  
  def to_param
    "#{user.first_name}".parameterize
  end
end