class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @person = User.find(current_user.id)
    @user_id = current_user.id
  end

  def show
    @user_group_ids = UserGroupThrough.where(user_id: current_user)
    @person = User.new
  end
end
