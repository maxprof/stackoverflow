FactoryGirl.define do
  factory :question do
    sequence(:id)
    title "test title"
    description "Test description"
    visitors 5
    association(:user)
  end
end
