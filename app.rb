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
  # @newQuestion = Question.new(params[:questions])
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

delete '/questions/:id' do
  @question = Question.find(params[:id])
  @question.destroy
  redirect "/users/#{current_user.id}"

  #(params[:question])
  # IF Update the question with the newly submitted input
  # if @question.delete(params[:question])
  #   redirect "/users/#{current_user.id}"
  # else
  #   redirect "/users/#{current_user.id}"
  # end
end

get '/questions/:question_id/answers/new' do
  @question = Question.find(params[:question_id])
  erb :"answers/new"
end

post '/questions/:question_id/answers' do
  @answer = Answer.new(params[:answer])
  @answer.question_id = params[:question_id]
  @answer.user_id = current_user.id
  ### OR
  # @question = Question.find(params[:question_id])
  # answer = @question.answer.new(params[:answer])
  # answer.user = current_user
  if @answer.save
    redirect "/users/#{current_user.id}"
  else
    erb :"answers/new"
  end
end


get '/answer/:id/edit' do
  @answer = Answer.find(params[:id])
  erb :"answers/edit-answer"
end

post '/answer/:id' do
  @answer = Answer.find(params[:id])
  if @answer.update(params[:answer])
    redirect "/users/#{current_user.id}"
  else
    erb :"answers/edit-answer"
  end
end

delete '/answer/:id' do
  @answer = Answer.find(params[:id])
  @answer.destroy
  redirect "/users/#{current_user.id}"
end

get '/users/:id' do
  @user = User.find(params[:id])
  @questions = @user.questions.order(:id)
  @answer = @user.answers.order(:id)
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
