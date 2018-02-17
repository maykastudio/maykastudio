require 'rails_helper'

RSpec.describe Project, type: :model do

  describe "validations" do
    subject { build(:project) }

    it { should validate_presence_of(:title) }
    it { should be_valid }
  end

  describe "#generate_secret_codes" do
    let(:project){ create(:project) }

    it "should have secret code" do
      expect(project.code.present?).to be_truthy
    end
  end

end
