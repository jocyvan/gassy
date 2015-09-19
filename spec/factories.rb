# This will guess the User class
FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "testes"
    password_confirmation "testes"
    role :user

    factory :admin do
      role :admin
    end
  end
end
