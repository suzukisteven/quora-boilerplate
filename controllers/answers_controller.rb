
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
