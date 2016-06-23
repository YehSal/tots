class Group < ActiveRecord::Base
  has_many :user_group_throughs
  has_many :users, through: :user_group_throughs
end
