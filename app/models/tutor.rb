class Tutor < ActiveRecord::Base
  belongs_to :user
  has_many :messages, :foreign_key => 'recipient_id'
  
  validates_presence_of :user_id
  validates :rate, presence: true, numericality: true, format: { :with => /\A\d{1,5}(\.\d{0,2})?\z/ }
  validates_length_of :description, maximum: 1000, allow_blank: true
  
  # This can be used for SEO friendliness
  #def to_param
  #  "#{user.fiMrst_name}".parameterize
  #end
end