class AddPictureFieldForUser < ActiveRecord::Migration
  def change
  	add_column :users, :picture, :string
  	add_column :users, :birthday, :string
  	add_column :users, :link, :string
  end
end
