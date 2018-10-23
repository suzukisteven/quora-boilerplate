

# VOTE CONTROLLER - (*** NOT *** ANSWER)

post '/answer/:id/votes' do
  @answer = Answer.find(params[:id])
  @vote = Vote.new(user_id: current_user.id, answer_id: @answer.id, upvote: true)
  @vote.save
  p @vote.errors
  redirect "/users/#{current_user.id}"
end

delete '/answer/:id/delete' do
  @answer = Answer.find(params[:id])
  @vote = Vote.find_by(user_id: current_user.id, answer_id: @answer.id)
  @vote.destroy
  redirect "/users/#{current_user.id}"
end

# Votes.where(answer_id: x, upvote: true).count - Votes.where(answer_id: x, upvote: false).count
