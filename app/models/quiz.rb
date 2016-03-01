# A simple quiz
class Quiz

  include DataMapper::Resource

  property :id, Serial
  property :name, String, length: 256, required: true
  has n, :questions
  has n, :answers, :through => :questions

  has n, :quiz_results

  def mark(answers)
    results = {}
    Quiz.get(id).questions.each do |question|
      results[question] = question.mark(answers[question.id.to_s])
    end
    results
  end

  def number_of_correct_answers
    correct = 0
    answers.each do |answer|
      if answer.correct
        correct += 1
      end
    end
    correct
  end

end
