# note that for local database, I had to first go into psql and manually create the sin_blog_development database, then i was able to create the migration and run rake db:migrate
# Nevermind the comment above, you can do rake db:create
configure :development do
 set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'sin_blog_development', pool: 2, username: ENV['mydbusername'], password: ENV['mydbpassword']}
 set :show_exceptions, true
end

# for heroku
configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end