class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :identity_url, :null => false
      t.string :firstname, :lastname
      t.string :email
      t.timestamps
    end
    
    add_index :users, :identity_url, :unique => true
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
