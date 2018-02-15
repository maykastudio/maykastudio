require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should be_valid }
  end
  
  describe '#administrator?' do

    context "user not have administrator permission" do
      let(:user) { create(:user) }
      
      it "should not have administrator role" do
        expect(user.administrator?).to be_falsey
      end
    end

    context "user have administrator permission" do
      let(:administrator) { create(:user, :administrator) }

      it "should have administrator role" do
        expect(administrator.administrator?).to be_truthy
      end
    end
    
  end

  describe "#remember_me" do
    let(:user){ create(:user) }

    it "should remember user" do
      expect(user.remember_me).to be_truthy
    end
  end

end
