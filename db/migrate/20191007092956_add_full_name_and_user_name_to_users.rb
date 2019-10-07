class AddFullNameAndUserNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :user_name, :string
    remove_column :users, :name, :string
  end
end
