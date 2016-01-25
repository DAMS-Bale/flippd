# A simple quiz
class Quiz

  include DataMapper::Resource

  property :id, Serial
  property :name, String, length: 256, required: true
  has n, :questions

  def mark(answers)
    # TODO: mark
    puts answers
    answers
  end

end
