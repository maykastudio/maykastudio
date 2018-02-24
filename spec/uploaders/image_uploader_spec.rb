require 'rails_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  let(:image){ build(:image) }
  let(:uploader){ ImageUploader.new(image, :file) }

  before do
    ImageUploader.enable_processing = true
    File.open(Rails.root.join('spec/fixtures/images/image.jpg')) { |f| uploader.store!(f) }
  end

  after do
    ImageUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumbnail version' do
    it "scales down image to be exactly 250 by 250 pixels" do
      expect(uploader.thumbnail).to have_dimensions(250, 250)
    end
  end

  context 'the preview version' do
    it "scales down image to be exactly 850 by 850 pixels" do
      expect(uploader.preview).to have_dimensions(850, 850)
    end
  end

  it "makes the image readable only to the owner and not executable" do
    expect(uploader).to have_permissions(0644)
  end
  
end