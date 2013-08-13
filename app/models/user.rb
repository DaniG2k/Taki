class User < ActiveRecord::Base
  has_one :tutor, dependent: :destroy
  #before_validation :update_tutor
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader
  
  # Validations
  validates_acceptance_of :terms
  #validates_associated :tutor, if: :is_tutor?
  validate :user_age, on: :update
  
  private
    #def update_tutor
      # Destroy tutor object if the user is currently
      # a tutor, and the is_tutor checkbox is unticked.
      #self.tutor.destroy if(self.tutor and !self.is_tutor)
    #end
    def user_age
      age = self.birthday
      if age.nil?
        errors.add(:birthday, "field required.")
      else
        # user needs to be 18 or older
        if age >= 18.years.ago
          errors.add(:birthday, "unaccepted. You may be a bit too young.")
        end
      end
    end
end