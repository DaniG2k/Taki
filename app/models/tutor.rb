class Tutor < ActiveRecord::Base
  belongs_to :user
  # The value of is_tutor needs to be found dynamically
  # Otherwise, the form will never validate because the value of is_tutor is true
  # since the first time that the form is edited, whcih is when the Tutor object is
  # created.
  #validates :rate, numericality: {greater_than: 0, less_than: 1000}, if: -> {user.is_tutor}
end
