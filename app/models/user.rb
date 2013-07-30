class User < ActiveRecord::Base
  has_one :tutor, dependent: :destroy
  accepts_nested_attributes_for :tutor, allow_destroy: true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader
  
  validates_acceptance_of :terms
  validate :tutor_or_student_checkbox_selected
  
  private
    def tutor_or_student_checkbox_selected
      unless self.is_tutor || self.is_student
        errors.add(:base, 'Select one or both of tutor/student checkboxes')
      end
    end
end
