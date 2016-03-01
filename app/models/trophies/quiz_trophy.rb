# A trophy of this type can be awarded when an user
# completes a certain quiz with a certain minimum score.
class QuizTrophy < Trophy

  def configure params
    @quiz = Quiz.get(params['quiz_id'])
    @minimum_score = params['score']
  end

  def should_be_awarded user
    !!QuizResult.all(:quiz => @quiz, :user => user, :score.gte => @minimum_score)
  end

  def to_s
    "Complete the #{@quiz.name} quiz with a score greater or equal to #{@minimum_score}"
  end

end
