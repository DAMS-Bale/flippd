# A user that has logged in to the system, used for authorisation and to
# present comments' authors.
class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true, length: 150
  property :email, String, required: true, length: 150
  property :lecturer, Boolean, allow_nil:true
  property :share_results, Boolean, default: false

  has n, :quiz_results
  has n, :page_views

  def is_lecturer
    #check for  a dot before the @
    if lecturer.nil?
      return email.partition("@").first.include? '.'
    else
      return lecturer
    end
  end

  def can_edit_comment comment
    return is_lecturer || comment.user == self
  end

  def total_score
    # Gets the total score for the quizzes of the user.
    total = 0
    for result in self.best_results
      total += result.score
    end
    total
  end

  def best_results
    # Gets the current best results for the user.
    QuizResults.all(
      :user => self,
      :best => true,
      :order => [:timestamp.desc, :score.desc]
    )
  end

  def add_quiz_result(quiz, score)
    # Firsty, create the new quiz result instance.
    current = QuizResult.create(
      :quiz => quiz,
      :user => self,
      :score => score,
      :best => false
    )

    # Secondly, get current best score for the quiz.
    best = QuizResult.get(
      :quiz => quiz,
      :user => self,
      :best => true,
      :limit => 1
    )

    # If this is the new best score, update.
    if best and best.score < score
      best.update(:best => false)
      current.update(:best => true)
    end
  end

end
