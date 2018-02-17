require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    it do
      get :index
      should render_template(:index)
    end
  end

end