require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require './models/post'
require './models/comment'

set :server, :puma
set :port, 3000
enable :sessions


# set :method_override, true
# use Rack::MethodOverride






# home, posts#index
['/', '/posts', '/posts/'].each do |path|
  get path do
    @posts = Post.order("created_at DESC")
    @title = "Welcome."
    erb :"posts/index"
  end
end






# show
get "/posts/:id" do
  @post = Post.find(params[:id])
  @title = @post.title
  @success_message = session[:notice]
  session[:notice] = nil
  erb :"posts/show"
end





# new
get "/posts/new" do
  @title = "Create post"
  @post = Post.new
  # @error_message = session[:error]
  # session[:error] = nil
  erb :"posts/new"
end





#create
post "/posts" do
 @post = Post.new(params[:post])
 if @post.save
  session[:notice] = 'Congrats! Love the new post'
  redirect "posts/#{@post.id}"
 else
  # puts env
  # puts request
  # @post.errors.full_messages.each do |message|
  #   puts message
  # end
  # session[:error] = "Custom error message here"
  erb :"posts/new"
 end
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





# delete 
delete "/posts/:id" do
  @post = Post.find(params[:id])
  @post.destroy
  redirect "/posts"
end






# show comments
get "/posts/:id/comments" do
  @post = Post.find(params[:id])
  @title = @post.title
  @comments = @post.comments
  erb :"comments/show"
end







helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end