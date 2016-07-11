FactoryGirl.define do
  factory :user do
    login "tester"
    email { Faker::Internet.email }
    Faker::Name.name
    country "Ukraine"
    address "Unosty 39"
    city "Vinnytsya"
    password "password"
  end
end
