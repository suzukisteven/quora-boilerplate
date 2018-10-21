require_relative './config/init.rb'
require 'date'

after{ActiveRecord::Base.connection.close}
enable :sessions

set :method_override, true
set :run, true

get '/' do
  @name = "Bob Smith"
  @variable = DateTime.now
  erb :"home"
end

get '/home' do
  erb :"home"
end

get '/signup' do
  erb :"signup"
end

post '/signup' do
  user = User.new(params[:user])
  if user.save
    redirect '/login'
  else
    erb :"signup"
  end
end

get '/loggedin' do
  @name = "Bob Smith"
  erb :"loggedin"
end

get '/questions' do
    # => params[:id] returns the value input in the :wildcard path, aka 20
    # @user = User.find(params[:id])
    erb :"questions"
end

post '/questions' do
  @newQuestion = current_user.questions.new(params[:questions])
  if @newQuestion.save
    redirect "/users/#{current_user.id}"
  else
    redirect '/questions'
  end
end

post '/questions/:id' do
  # Retrieve specified question from the database
  @question = Question.find(params[:id])
  # IF Update the question with the newly submitted input
  if @question.update(params[:question])
    redirect "/users/#{current_user.id}"
  else
    erb :"/questions/edit"
  end
end

get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  erb :"questions/edit"
end

delete '/questions/:id/delete' do
  @question = Question.find(params[:id])
  @question.delete#(params[:question])
  # IF Update the question with the newly submitted input
  # if @question.delete(params[:question])
  #   redirect "/users/#{current_user.id}"
  # else
  #   redirect "/users/#{current_user.id}"
  # end
end

get '/users/:id' do
  @user = User.find(params[:id])
  @questions = @user.questions
  erb :"users"
end

get '/login' do
  erb :"login"
end

post '/login' do
  # apply a authentication method to check if a user has entered a valid email and password
  user = User.find_by(username: params['user']['email'])

  # if a user has successfully been authenticated, you can assign the current user id to a session
  if user && user.authenticate(params['user']['password'])
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    redirect '/login'
  end
end

post '/logout' do
  # kill a session when a user chooses to logout, for example, assign nil to a session
  # redirect to the appropriate page

  session[:user_id] = nil
  redirect'/'

  # if logged_in?
  #   session.destroy
  #   redirect '/login'
  # else
  #   redirect '/'
  # end
end
