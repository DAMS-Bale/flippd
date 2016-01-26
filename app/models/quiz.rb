# A simple quiz
class Quiz

  include DataMapper::Resource

  property :id, Serial
  property :name, String, length: 256, required: true
  has n, :questions

  def mark(answers)
    results = []
    Question.all(:quiz => id).each do |question|
      results[question.id] = question.mark(answers.get(question_id))
    end
    results
  end
end
