require 'rails_helper'

RSpec.describe Image, type: :model do

  describe "validations" do
    subject { build(:image) }

    it { should be_valid }
  end

  describe "#to_json" do
    let(:image){ create(:image) }

    it "should generate valid json" do
      json = {
        id: image.id,
        position: image.position,
        url: image.file.thumbnail.url,
        preview: image.file.preview.url,
        download: nil,
        selected: image.selected
      }

      expect(image.to_json).to eq(json)        
    end
  end

end
