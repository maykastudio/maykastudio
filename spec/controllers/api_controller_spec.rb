require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe 'GET #ping' do
    it "should respond with pong json" do
      process :ping
      result = JSON.parse(response.body)
      expect(result).to eq({"pong" => "ok"})
    end
  end

end