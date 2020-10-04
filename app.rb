require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'
enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

before '/goal' do
  if current_user.nil?
    redirect '/'
  end
end

get '/' do
  @posts = Post.all
  @categories = Category.all
  erb :index
end

get '/home' do
  @categories = Category.all
  @follows = Follow.all
  if current_user.nil?
    redirect '/'
  else
    @posts = current_user.posts
  end
  erb :home
end

get '/signin' do
  erb :index
end

get '/signup' do
  erb :signup
end

post '/signin' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

post '/signup' do
  user = User.create(
    name: params[:name],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
  )
  if user.persisted?
    session[:user] = user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/goal' do
  @categories = Category.all
  if current_user.nil?
    redirect '/'
  end
  erb :post
end

post '/goal' do
  date = params[:due_date].split('-')
      if Date.valid_date?(date[0].to_i, date[1].to_i, date[2].to_i)
      current_user.posts.create!(title: params[:title],due_date: Date.parse(params[:due_date]),introduction: params[:introduction])
      redirect '/'
    else
      redirect '/post'
    end
end

post '/goal/:id/join' do
  @posts = Post.all
  post = Post.find(params[:id])
  @follow = current_user.follows.create(post_id: params[:post_id])
  redirect '/'
end

get '/comment' do
  @posts = Post.all
  erb :action
end