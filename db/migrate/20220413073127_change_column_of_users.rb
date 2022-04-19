class ChangeColumnOfUsers < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column_null :users, :name, :string, false
      change_column_null :users, :email, :string, false
    end

    def down
      change_column_null :users, :name, :string, true
      change_column_null :users, :email, :string, true
    end
  end
end
