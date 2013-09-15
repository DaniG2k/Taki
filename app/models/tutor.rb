class Tutor < ActiveRecord::Base
  belongs_to :user
  has_many :educational_experiences, dependent: :destroy
  accepts_nested_attributes_for :educational_experiences,
    allow_destroy: true,
    reject_if: lambda {|attr| %w(university major minor).all? { |val| attr[val].blank? }}
 
  validates_presence_of :user_id
  validates :rate, presence: true, numericality: true, format: { :with => /\A\d{1,5}(\.\d{0,2})?\z/ }
  validates_length_of :description, maximum: 1000, allow_blank: true
  validate :limit_educational_experiences, on: :update
  
  private
    def limit_educational_experiences
      if educational_experiences.count > 5
        errors.add(:educational_experiences_attributes, "#{I18n.t('errors.educational_experiences_attributes.too_many')}")
      end
    end
    
  # This can be used for SEO friendliness
  #def to_param
  #  "#{user.fiMrst_name}".parameterize
  #end
end