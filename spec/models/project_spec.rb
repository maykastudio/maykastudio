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

  describe "#update_images_position" do
    let!(:project){ create(:project) }
    let(:images){ 2.times.map{ create(:image, project: project) } }
    
    it "should set image position" do
      project.images.each do |image|
        expect(image.position.present?).to be_truthy
      end
    end

  end
  

end
