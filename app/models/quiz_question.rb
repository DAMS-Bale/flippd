# This model represents a question for a quiz
class Question
  include DataMapper::Resource

  belongs_to :quiz

  property :id, Serial
  property :text, String, length: 1024, required: true

  has n, :answers

  def mark(answer_id)
    answer = Answer.get(answer_id)
    return answer.correct?
  end
end
