require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:development.sqlite3"
set :sessions, true

require "./models"

require 'bundler/setup' 
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true

get '/' do 
	erb :home
end

get '/wrong' do
	erb :login_failed
end
	
post '/sign-in' do
	# puts "my params are" + params.inspect
	@user = User.where(username: params[:username]).first
	if @user.password == params[:password]
		flash[:notice] = "User signed in successfully."
		redirect "/"
	else
		flash[:alert] = "There was a problem signing you in."
		redirect "/wrong"
	end
end


def current_user	
 if session[:user_id] 
 	@current_user = User.find(session[:user_id]) 
end
end
