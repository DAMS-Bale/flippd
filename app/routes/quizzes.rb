class Flippd < Sinatra::Application

  post '/quiz/:id/mark' do

    # Get the parameters from the form
    @answers = params[:answers]

    @results = Quiz.get(params[:id])

    # Show the quiz view
    pass # TODO
    # erb :quiz
  end



end
