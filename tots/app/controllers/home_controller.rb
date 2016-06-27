class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @person = User.find(current_user.id)
  end

  def show
    @user_groups = UserGroupThrough.where(user_id: current_user)

    @person = User.new

  end
end
