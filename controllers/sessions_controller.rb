
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
