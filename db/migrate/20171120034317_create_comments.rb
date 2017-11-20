class CreateComments < ActiveRecord::Migration[5.1]
  def self.up
   create_table :comments do |t|
     t.text :content
     t.references :post, foreign_key: true
     t.timestamps
   end
 end

 def self.down
   drop_table :comments
 end
end