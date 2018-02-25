FactoryBot.define do
  factory :view do
    viewable_id { create(:project).id }
    viewable_type { 'Project' }
    session { SecureRandom.hex }
    user_agent { "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36" }
    user
  end
end
