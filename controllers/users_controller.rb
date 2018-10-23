
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

get '/users/:id' do
  @user = User.find(params[:id])
  @questions = @user.questions.order(:id)
  @answer = @user.answers.order(:id)
  # @votes = Votes.where(:answer_id, upvote: true).count - Votes.where(:answer_id, upvote: false).count
  erb :"users"
end
