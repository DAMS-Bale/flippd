# This entity represents a possible answer to a question of a quiz
class Answer
  include DataMapper::Resource

  # Association to the question
  belongs_to :question

  property :id, Serial
  property :text, String, length: 1024, required: true
  property :correct, Boolean

end
