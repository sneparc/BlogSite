require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:development.sqlite3"
set :sessions, true

require "./models"

require 'bundler/setup' 
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true

get '/sign_up' do
	erb :sign_up
end

get '/' do 
	@all_users= User.all
	@all_posts =Post.all
	erb :home

end

get '/wrong' do
	erb :login_failed
end

get '/profile' do
	@user = User.find(session[:user_id])
	erb :profile
end


	
post '/sign-in' do
	puts "my params are" + params.inspect
	@user = User.where(username: params[:username]).first
	if @user && @user.password == params[:password]
		session[:user_id] =@user.id
		flash[:notice] = "User signed in successfully."
		redirect "/profile"
	else
		flash[:alert] = "There was a problem signing you in."
		redirect "/wrong"
	end
end


def current_user	
 if session[:user_id] 
 	@current_user = User.find(session[:user_id]) 
end

helpers do
def current_user
if session[:user_id]
@current_user = User.find(session[:user_id])
end
end
end

end

post '/sign-up' do
	@user = User.new(params[:user])
	@user.save
	session[:user_id] =@user.id
		puts "my params are" + params.inspect
	redirect "/"
end

post '/posts/new' do
	puts "my params are" + params.inspect
	@post = Post.new(params[:post])
	@post.user_id = session[:user_id]
	@post.save
	redirect "/profile"
end
# not prepended
# fname: params[:fname],lname: params[:lname], username: params[:username], email: params[:email], password: params[:password])
