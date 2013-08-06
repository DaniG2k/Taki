class User < ActiveRecord::Base
  has_one :tutor, dependent: :destroy
  accepts_nested_attributes_for :tutor
  before_validation :update_tutor
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader
  
  # Validations
  validates_acceptance_of :terms
  validates_associated :tutor, if: :is_tutor?
  validate :tutor_or_student_checkbox_selected, on: :update
  
  private
    def update_tutor
      # Destroy tutor object if the user is currently
      # a tutor, and the is_tutor checkbox is unticked.
      self.tutor.destroy if(self.tutor and !self.is_tutor)
    end
    
    def tutor_or_student_checkbox_selected
      unless self.is_tutor or self.is_student
        errors.add :base, 'Select one or both of tutor/student checkboxes'
      end
    end
end