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

  describe "#to_json" do
    let!(:project){ create(:project) }
    let!(:image){ create(:image, project: project) }

    it "should generate valid json" do
      json = {
        code: project.code,
        title: project.title,
        download_count: project.download_count,
        selected: [],
        images: project.images.reload.map{ |i| i.to_json },
      }

      expect(project.to_json).to eq(json)        
    end
  end

  describe "#select_images" do
    let(:project){ create(:project, download_count: 5) }
    let(:image){ create(:image, project: project) }

    it "should mark image as selected" do
      project.select_images([image.id])
      image.reload

      expect(image.selected).to be_truthy
    end
  end
  
end
