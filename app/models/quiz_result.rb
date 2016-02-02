# This model represents the result for a quiz completed by a user
class QuizResult
  include DataMapper::Resource

  property :id, Serial

  belongs_to :quiz
  belongs_to :user

  property :score, Integer, required: true

  property :timestamp, DateTime, required: true, default: lambda{
    |p,s| DateTime.now
  }

end
