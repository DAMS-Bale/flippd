class Flippd < Sinatra::Application

  get '/quiz/:id' do
    @quiz = Quiz.get(params[:id])
    erb :quiz
  end

  post '/quiz/:id/mark' do
    # Get the answers from the form
    @answers = extract_post_data(params)
    quiz = Quiz.get(params[:id])
    @results = quiz.mark(@answers)
    # Only save if logged in.
    if @user then

      score = @results.select{ |q_id, res| res == true }.length

      # Add the result and calculates the best score for the result.
      @user.add_quiz_result(quiz, score)

    end
    erb :quiz_results
  end

  def extract_post_data(post)
    # So far we are only dealing with one type of questions.
    # This hash could be replaced with an object in future
    # iterations if need be.
    answers = Hash.new

    # The post form data specifies submitted answers in the form:
    # qustion_id : answer_id
    # The select statement ensures that the param's key is a number (i.e. it is
    # a question_id).
    params.each.select { |key, value| key.to_i != 0 }.each do |q_id, ans_id|
       answers["#{q_id}"] = ("#{ans_id}")
    end
    return answers
  end

end
