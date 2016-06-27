class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group_form = Group.new
    # render: create
  end

  def create
    # create group
    group_hash = params.select[:group]
    i = Group.new
    i.name = group_hash[:name]
    i.description = group_hash[:description]
    i.private = group_hash[:private]
    i.save!

     # update through table
    j = UserGroupThrough.new
    j.user_id = current_user.id
    j.group_id = i.id
    j.save!

    binding.pry
    render :show
  end

  def show
    id = params[:id].to_i
    @group = Group.find(id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
