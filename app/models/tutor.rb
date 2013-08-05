class Tutor < ActiveRecord::Base
  belongs_to :user
  #validates_numericality_of :rate, greater_than: 0, if: -> :is_tutor?
end