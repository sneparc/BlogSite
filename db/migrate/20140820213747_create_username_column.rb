class CreateUsernameColumn < ActiveRecord::Migration
  def change
  	add_column(:users, :username, :string)
  end
end
