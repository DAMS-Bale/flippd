class Flippd < Sinatra::Application

  before '/leaderboard' do
    unless @user
      halt 401, "Error 401, Unauthorised"
    end
  end

  get '/leaderboard' do

    @leaderboard = Leaderboard.results
    erb :leaderboard

  end

  get '/leaderboard/switch' do
    @user.share_results = !@user.share_results
    @user.save
    redirect to('/leaderboard')
  end



end
