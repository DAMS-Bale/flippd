require 'digest'

# The trophies manager is responsible for loading trophies
# when the application is started, and assigning trophies to users
# according to each trophy's own logic, making sure not to
# award the same trophy to an user twice.
class TrophiesManager

  def load_trophies json_trophies
    @loaded_trophies = []
    json_trophies.each do |json_trophy|

      json_hash = TrophiesManager.configuration_hash json_trophy

      class_name = json_trophy['type']

      # First, make sure that the class is valid and exists.
      begin
        trophy_type = class_name.constantize
      rescue
        raise "#{class_name} is not a valid trophy type."
      end

      # Secondly, make sure it is a trophy.
      unless trophy_type.is_a? Trophy
        raise "#{class_name} is not a trophy and can't be instantiated."
      end

      # Creates or get the trophy from the database
      trophy = trophy_type.first_or_create(
        :json_hash => json_hash,
        :name => name,
      )

      # Configures the trophy
      trophy.configure(json_trophy['configuration'])

      # Updates the description of the trophy
      trophy.update(:descrition => trophy.to_s)

      @loaded_trophies.append trophy

    end


  end

  def self.configuration_hash
    # Given the configuration dictionary, returns the hash
    # to store in the database.
    Digest::SHA256.hexdigest json_trophy.to_json
  end


end
