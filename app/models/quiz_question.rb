# This model represents a question for a quiz
class Question
  include DataMapper::Resource

  belongs_to :quiz

  property :id, Serial
  property :text, String, length: 1024, required: true

  has n, :answers

  def mark(answer_id)
    results = {:correct => [], :incorrect => [], :missed => []}
    answer = Answer.get(answer_id)
    if answer.correct?
      results[:correct].push(answer)
    else
      results[:incorrect].push(answer)
    end

    correct_answers = Answer.all(:question => id, :correct => true)
    correct_answers.each do |correct_answer|
      unless answer_id == correct_answer.id
        results[:missed].push(correct_answer)
      end
    end

    return results
  end
end
