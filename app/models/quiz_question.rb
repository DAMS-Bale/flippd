# This model represents a question for a quiz
class Question
  include DataMapper::Resource

  belongs_to :quiz

  property :id, Serial
  property :text, String, length: 1024, required: true

end
