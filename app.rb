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

get '/' do
  @posts = Post.all
  @categories = Category.all
  erb :index
end

get '/home' do
  @posts = Post.all
  @categories = Category.all
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

get '/post' do
  @categories = Category.all
  erb :post
end

post '/post' do
  Post.create(
    user_id: session[:user],
    title: params[:title],
    category_id: params[:category_id],
    due_date: params[:date]
  )
  redirect '/'
end