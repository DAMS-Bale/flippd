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

  def best_results
    repository.adapter.select("
      SELECT q1.id AS id,
             quiz_id AS quiz_id
      FROM   quiz_results AS q1
      WHERE  user_id = #{self.id}
      AND    score = (
        SELECT  MAX(q2.score)
        FROM    quiz_results AS q2
        WHERE   q2.quiz_id = q1.quiz_id
        AND     q2.user_id = q1.user_id
      )
      GROUP BY quiz_id
      ORDER BY timestamp DESC, score DESC
    ")
  end


end
