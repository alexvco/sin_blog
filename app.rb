# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'


set :server, :puma
set :port, 3000

enable :sessions



class Post < ActiveRecord::Base  
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end



helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end



# index
get "/" do
  @posts = Post.order("created_at DESC")
  @title = "Welcome."
  erb :"posts/index"
end

# new
get "/posts/new" do
  @title = "Create post"
  @post = Post.new
  erb :"posts/new"
end

# create
# post "/posts" do
#   @post = Post.new(params[:post])
#   if @post.save
#     redirect "posts/#{@post.id}"
#   else
#     erb :"posts/new"
#   end
# end

post "/posts" do
 @post = Post.new(params[:post])
 if @post.save
   redirect "posts/#{@post.id}", :notice => 'Congrats! Love the new post. (This message will disappear in 4 seconds.)'
 else
   # redirect "posts/new", :error => 'Something went wrong. Try again. (This message will disappear in 4 seconds.)'
   session[:error] = "errrror"
   redirect "posts/new"
 end
end



# show
get "/posts/:id" do
  @post = Post.find(params[:id])
  @title = @post.title
  erb :"posts/show"
end

# edit
get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  @title = "Edit Form"
  erb :"posts/edit"
end

# update
put "/posts/:id" do
  @post = Post.find(params[:id])
  @post.update(params[:post])
  redirect "/posts/#{@post.id}"
end


