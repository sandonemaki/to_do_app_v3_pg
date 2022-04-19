class AddImageNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_name, :string, null: false, default: "default_user.jpg"
  end
end
