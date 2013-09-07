class User < ActiveRecord::Base
  has_one :tutor, dependent: :destroy
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_id'
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader
  
  validates_acceptance_of :terms
  validate :user_age, on: :update
  # Remove on: :update to have this validation on all pages.
  validates_inclusion_of :time_zone, on: :update, in: ActiveSupport::TimeZone.zones_map(&:name)
  
  def fullname
    "#{first_name} #{last_name}"
  end
  
  private
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