# This is an abstract class representing a generic trophy.
class Trophy

  include DataMapper::Resource

  # Defines the default image for the trophies.
  DEFAULT_IMAGE="//raw.githubusercontent.com/DAMS-Bale/flippd-trophies/master/medal.png"

  property :id, Serial
  property :json_hash, String, required: true, length: 64
  property :type, DataMapper::Property::Discriminator
  property :name, String, required: true, length: 64
  property :description, String, default: '', length: 1024
  property :image, String, default: DEFAULT_IMAGE, required: false, length: 255

  has n, :users, :through => Resource

  def new *args
    # This method prevents a trophy object to be instantiated direclty.
    # A specific type of trophy, such as "QuizTrophy", shuld be instantiated
    # instead.
    if self.instance_of Trophy
      raise 'the trophy class cannot be instantiated directly'
    end
    super
  end

  def configure parameters
    raise 'each trophy should define its own configuration logic'
  end

  def should_be_awarded user
   raise 'each trophy should define its own logic to determine whether it has been obtained or not'
  end

  def to_s
    raise 'each trophy should define its own method to get its human-readable awarding rule'
  end

end
