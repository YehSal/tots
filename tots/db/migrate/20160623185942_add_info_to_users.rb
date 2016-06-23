class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :picture, :string
    add_column :users, :location, :string
    add_column :users, :availability, :integer
    add_column :users, :status, :string
  end
end
