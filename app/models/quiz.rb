# A simple quiz
class Quiz

  include DataMapper::Resource

  property :id, Serial
  property :name, String, length: 256, required: true
  has n, :questions

  def mark(answers)
    results = []
    Question.all(:quiz => id).each do |question|
      var r = question.mark(answers.select { |answer| answer.id == question.id})
      results[question.id] = r
    end
  end

end
