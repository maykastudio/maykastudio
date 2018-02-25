class ApiController < ApplicationController
  
  def ping
    render json: { pong: :ok }
  end

end
