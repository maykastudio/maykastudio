FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }  

    trait :administrator do
      after(:create) { |user| user.permissions.create(role: :administrator) }
    end

    trait :invalid do
      email { nil }
    end
  end
end
