FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    email 'joe@example.com'
    password 'password'
  end

  factory :user_two, class: User do
    first_name 'Sarah'
    last_name 'Doe'
    email 'sarah@example.com'
    password 'password'
  end
end
