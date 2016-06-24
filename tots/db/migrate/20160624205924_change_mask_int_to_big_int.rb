class ChangeMaskIntToBigInt < ActiveRecord::Migration
  def change
        remove_column :users, :availability, :integer
        add_column :users, :availability, :bigint
  end
end
