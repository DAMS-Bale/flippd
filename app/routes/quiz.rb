class Flippd < Sinatra::Application

  get '/quiz/:id' do

    @quiz = Quiz.get(params[:id])

    erb :quiz
  end

  post '/quiz/:id/mark' do
    # Get the parameters from the form
    @answers = params[:answers]

    @results = Quiz.get(params[:id]).mark(@answers)

    @quiz = Quiz.get(params[:id])
    erb :quiz
  end


end
