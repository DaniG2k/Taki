# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user_id 1
    conversation_id 1
    subject "MyString"
    body "MyText"
  end
end
