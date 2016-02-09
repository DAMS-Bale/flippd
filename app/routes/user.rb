class Flippd < Sinatra::Application

  before '/user/:id' do
    unless @user
      halt 401, "Error 401, Unauthorised"
    end
  end

  get '/user/:id' do

    # Get the parameters from the form
    @userId = params[:id]

    # Get the correct user
    @results_user = User.get(@userId)

    @results = @results_user.quiz_results
    @best_results = @results_user.best_results

    erb :user

  end



end
