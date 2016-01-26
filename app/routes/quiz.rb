class Flippd < Sinatra::Application

  get '/quiz/:id' do

    @quiz = Quiz.get(params[:id])

    erb :quiz
  end

  post '/quiz/:id/mark' do
    # Get the answers from the form
    @answers = params.select { |key, value| key.to_i != 0}
    # Set the answers to the correct type (integer)
    @answers = @answers.each do |question_id, answer_ids|
      question_id = question_id.to_i
      answer_ids = answer_ids.each { |a_id| a_id.to_i }
    end

    @results = Quiz.get(params[:id]).mark(@answers)
    puts @results
    erb :quiz_results
  end


end
