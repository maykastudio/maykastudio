FactoryBot.define do
  factory :project do
    sequence(:title) { |i| "#{FFaker::Lorem.word} #{i}" }
    user_id { create(:user).id }

    trait :invalid do
      title { nil }
    end
  end
end
