class AddConfirmableToDeviseV1 < ActiveRecord::Migration
  def self.up
    add_column :users, :unconfirmed_email, :string
    add_index  :users, :confirmation_token, :unique => true
  end
  def self.down
    remove_index  :users, :confirmation_token
    remove_column :users, :unconfirmed_email
  end
end
