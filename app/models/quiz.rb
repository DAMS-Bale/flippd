# A simple quiz
class Quiz

  include DataMapper::Resource

  property :id, Serial
  property :name, String, length: 256, required: true
  has n, :questions

  has n, :quiz_results

  def mark(answers)
    results = {}
    Question.all(:quiz => Quiz.get(id)).each do |question|
      results[question.id] = question.mark(answers[question.id.to_s])
    end
    results
  end
end
