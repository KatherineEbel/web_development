require 'tilt/erubis' # => interface over Ruby template engines
require "sinatra"
require "sinatra/reloader"
require 'yaml'
require 'pry'

before do
  @users = YAML.load_file 'data/users.yaml'
  @number_of_users = @users.keys.size
end

helpers do
  def count_interests(users)
    users.each_pair.map {|name,value| value[:interests] }.flatten.size
  end
end

get '/' do
  @title = "Users and Interests"
  redirect "/users"
  erb :home
end

get '/users' do
  @title = "Users"
  erb :users
end

get '/user/:name' do
  @name = params[:name]
  @title = "Info for #{@name}"
  @email = @users[@name.to_sym].fetch(:email)
  @interests = @users[@name.to_sym].fetch(:interests)
  @other_users = @users.select {|name, _| name != @name.to_sym }
  erb :user
end
