class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_acceptance_of :terms
  validate :tutor_or_student_checkbox_selected
    
  private
    def tutor_or_student_checkbox_selected
      unless self.tutor || self.student
        errors.add(:base, 'Select one or both of tutor/student checkboxes')
      end
    end
end
