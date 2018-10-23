
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

get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  erb :"questions/edit"
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
