class User < ActiveRecord::Base
  has_one :tutor, dependent: :destroy
  accepts_nested_attributes_for :tutor
  before_save :update_tutor
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader
  
  # Validations
  validates_acceptance_of :terms
  validate :tutor_or_student_checkbox_selected
  
  private
    def tutor_or_student_checkbox_selected
      unless self.is_tutor or self.is_student
        errors.add :base, 'Select one or both of tutor/student checkboxes'
      end
    end
    
    def update_tutor
      self.tutor.destroy if(self.tutor and !self.is_tutor)
    end
end
