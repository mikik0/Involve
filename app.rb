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
  @posts = Post.all.order(id: "DESC")
  @follow = Follow.where(post_id: @posts).count
  erb :index
end

get '/home' do
  @posts = Post.all
  @follows = current_user.follows.order(id: "DESC")
  #直す
  @follow = Follow.where(post_id: @posts).count
  if current_user.nil?
    redirect '/'
  end
  p "######/home######################"
  for post in @posts do
    p "==================="
    p post.follows
  end
  if current_user.nil?
    redirect '/'
  else
    @posts = current_user.posts.order(id: "DESC")
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
      post = current_user.posts.create!(title: params[:title],due_date: Date.parse(params[:due_date]),introduction: params[:introduction],category_id: params[:category_id])
      current_user.follows.create(post_id: post.id)
      redirect '/'
    else
      redirect '/post'
    end
end

#目標に参加
post '/goal/:post_id/join' do
  @posts = Post.all.order(id: "DESC")
  post = Post.find(params[:post_id])
  @follow = current_user.follows.create(post_id: params[:post_id],user_id: params[:user_id])
  redirect '/'
end
#目標に不参加


get '/comment' do
  @posts = Post.all
  @follows = current_user.follows.order(id: "DESC")
  if current_user.nil?
    redirect '/'
  end
  erb :action
end

get '/goal/:post_id/result' do
  @posts = Post.all.order(id: "DESC")
  post = Post.find(params[:post_id])
  @follow = current_user.follows.create(post_id: params[:post_id],user_id: params[:user_id])
  erb :details
end

get '/goal/:post_id/details' do
  @post = Post.find(params[:post_id])
  @comments = Comment.where(post_id: @post).order(id: "DESC")
  erb :goal
end

post '/goal/comment' do
  current_user.comments.create(post_id: params[:post_id],user_id: params[:user_id],comment: params[:comment])
  redirect '/home'
end

post '/done/:post_id' do
  @post = Post.find(params[:post_id])
  if @post.done == 0
    @post.update(done: 1)
  else @post.done == 1
    @post.update(done: 0)
  end
  p "###############%%%%%%########3"
  p @post.done
  redirect '/home'
end
