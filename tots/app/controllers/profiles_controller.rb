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

    @profile = User.find(params['id'])

    converter = MaskService.new(0,0)
    days = converter.to_info(@profile.availability)[0]
    hours = converter.to_info(@profile.availability)[1]
    @hours = hours
    @monday = days.include? "monday"
    @tuesday = days.include? "tuesday"
    @wednesday = days.include? "wednesday"
    @thursday = days.include? "thursday"
    @friday = days.include? "friday"
    @saturday = days.include? "saturday"
    @sunday = days.include? "sunday"
  end

  def show
  end

  def update
    binding.pry
    profile = ProfileService.new(params,current_user.id)
    profile.parse
  end

  def destroy
  end
end
