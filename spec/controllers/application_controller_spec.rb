require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  describe '#after_sign_in_path_for' do
    let(:user){ create(:user, :administrator) }

    it "should redirect to the /manage" do
      expect(subject.after_sign_in_path_for(user)).to eq(manage_root_path)
    end
  end

end