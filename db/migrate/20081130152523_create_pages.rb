class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string      :slug,  :null => false
      
      t.string      :title, :null => false
      t.text        :body,  :null => false
      
      t.references  :user,  :null => false
      
      t.integer     :version
      
      t.datetime    :locked_at
      t.references  :locked_by
      
      t.timestamps
    end
    
    add_index :pages, :slug, :unique => true
    add_index :pages, :title, :unique => true
  end

  def self.down
    drop_table :pages
  end
end
