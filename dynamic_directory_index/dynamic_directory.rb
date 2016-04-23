require 'tilt/erubis' # => interface over Ruby template engines
require "sinatra"
require "sinatra/reloader"
require 'pry'

get "/" do
  @title = "All Files"
  @public = Dir.foreach('public/').map.sort
  @public.reverse! if params[:sort] == "descending"
  erb :home
end
