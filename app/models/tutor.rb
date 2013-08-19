class Tutor < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  validates_numericality_of :rate, greater_than: 0
  validates_length_of :description, maximum: 1000, allow_blank: true
  # This can be used for SEO friendliness
  #def to_param
  #  "#{user.first_name}".parameterize
  #end
end