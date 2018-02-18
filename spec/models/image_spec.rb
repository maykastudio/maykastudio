require 'rails_helper'

RSpec.describe Image, type: :model do

  describe "validations" do
    subject { build(:image) }

    it { should be_valid }
  end

end
