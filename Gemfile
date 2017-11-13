source :rubygems

gem "sinatra"
gem "activerecord"
gem "sinatra-activerecord"
gem 'sinatra-flash'
gem 'sinatra-redirect-with-flash'
gem "pg"

group :development do
 gem "tux" # tux is what allows you to do rails c in sinatra (instead of rails c you type in tux), where you can then do stuff like: Post.create(title: 'Testing the title', body: 'Lorem ipsum dolor sit amet, consectetur adipiscin')
 # actually you dont even need tux, you can do irb and then type in require './app.rb' and voila, you now have access to Post.all etc...
end

group :production do
 # gem 'pg'
end