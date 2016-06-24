class ProfilesController < ApplicationController
  def index
  end

  def create
    profile = ProfileService.new(params,current_user.id)
    profile.parse
  end

  def new
    @profile = User.find(current_user.id)
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
