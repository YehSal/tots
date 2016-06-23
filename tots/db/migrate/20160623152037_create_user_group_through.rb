class CreateUserGroupThrough < ActiveRecord::Migration
  def change
    create_table :user_group_throughs do |t|
      t.string :user_id
      t.string :group_id
    end
  end
end
