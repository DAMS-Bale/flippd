# This model represents a question for a quiz
class Question
  include DataMapper::Resource

  belongs_to :quiz

  property :id, Serial
  property :text, String, length: 1024, required: true

  has n, :answers

  def mark(answers)
    results = [:correct => [], :incorrect => [], :missed => []]

    answers.each do |answer_id|
      if Answers.first(answer_id).correct?
        results[:correct].push(answer)
      else
        results[:incorrect].push(answer)
      end
    end

    correct_answers = Answers.all(:question => id, :correct? => true)
    correct_answers.each do |answer|
      unless answers.include(answer.id)
        results[:missed].push(answer)
      end
    end

    return results
  end
end
