class Tutor < ActiveRecord::Base
  belongs_to :user
  validates :rate, numericality: {greater_than: 0, less_than: 1000}
end
