# This will guess the User class
FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "person ##{n}" }
    sequence(:email) { |n| "person##{n}@example.com" }
    password "testes"
    password_confirmation "testes"
    role :user

    factory :admin do
      role :admin
    end
  end

  factory :station do
    user
    sequence(:name) { |n| "station ##{n}" }
    city "São Luis"
    latitude -2.39487529
    longitude -10.4387323
  end

  factory :fuel_gasoline, class: Fuel do
    name "Gasoline"
    status :active

    factory :fuel_diesel do
      name "Diesel"
    end
  end

  factory :price_gasoline, class: Price do
    association :fuel, :factory => :fuel_gasoline
    station
    value 3.2

    factory :price_diesel do
      fuel_diesel
      value 2.8
    end
  end

  factory :comment do
    name "Unkown"
    station
    content "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    factory :comment_with_user do
      user
    end
  end

  factory :follow do
    user
    station
  end
end
