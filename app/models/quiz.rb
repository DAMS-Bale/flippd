# A simple quiz
class Quiz

  include DataMapper::Resource

  property :id, Serial
  property :name, String, length: 256, required: true

end
