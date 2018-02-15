require 'rails_helper'

RSpec.describe Permission, type: :model do

  describe "validations" do
    subject { build(:permission) }

    it { should be_valid }
  end

end
