require_relative './config/init.rb'
require 'date'

after{ActiveRecord::Base.connection.close}
enable :sessions

# set :method_override, true
set :run, true

get '/' do
  @name = "Bob Smith"
  @variable = DateTime.now
  erb :"home"
end

get '/home' do
  erb :"home"
end
