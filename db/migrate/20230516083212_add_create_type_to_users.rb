class AddCreateTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :create_type, :integer, default: 0
  end
end
