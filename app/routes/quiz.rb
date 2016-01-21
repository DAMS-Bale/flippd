class Flippd < Sinatra::Application

  get '/quiz/:id' do

    @quiz = Quiz.get(params[:id])

    erb :quiz
  end


end
