FactoryBot.define do
  factory :image do
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/image.jpg'), 'image/jpeg') }
    project_id { create(:project).id }
  end

  trait :invalid do
    file { nil }
  end
end
