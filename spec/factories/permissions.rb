FactoryBot.define do
  factory :permission do
    user_id { create(:user).id }
  end
end
