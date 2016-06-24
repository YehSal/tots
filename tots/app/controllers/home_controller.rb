class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @person = User.new
  end
end
