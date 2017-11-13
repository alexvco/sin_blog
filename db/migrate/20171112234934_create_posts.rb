class CreatePosts < ActiveRecord::Migration[5.1]
  def self.up
   create_table :posts do |t|
     t.string :title
     t.text :body
     t.timestamps
   end
 end

 def self.down
   drop_table :posts
 end
end

# Note that i had to first manually create the db in psql

# to create this file (along with the db folder and all the subfolders and files within it): 
# $ rake db:create_migration NAME=create_posts

# then had to manually insert all the content in this file and then
# $ rake db:migrate