# A trophy of this type can be awarded when the user reaches
# a given number of comments.
class CommentsTrophy

  def configure params
    @number_of_comments = params['comments']
  end

  def should_be_awarded user
    Comment.count(:user => user) > @number_of_comments
  end

  def to_s
    "Write at least #{@number_of_comments} comments"
  end

end
