class CreateProfilesTable < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
  		t.string :fname
  		t.string :lname
  		t.string :email
  		t.integer :phone_number
  		t.datetime :birthday
  		t.integer :user_id
  	end
  end
end
