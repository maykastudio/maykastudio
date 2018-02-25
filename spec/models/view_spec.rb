require 'rails_helper'

RSpec.describe View, type: :model do

  describe 'validations' do
    subject { create(:view) }

    it { should validate_presence_of(:session) }
    it { should validate_presence_of(:user_agent) }
  end

end
