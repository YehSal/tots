class CreateGroup < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :locked?
      t.string :description
    end
  end
end
