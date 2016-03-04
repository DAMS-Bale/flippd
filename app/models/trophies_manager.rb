require 'digest'

# The trophies manager is responsible for loading trophies
# when the application is started, and assigning trophies to users
# according to each trophy's own logic, making sure not to
# award the same trophy to an user twice.
class TrophiesManager

  def initialize
    @loaded_trophies = []
  end

  def load_trophies json_trophies
    # Loads the trophies from the configuration section of the
    # JSON file.

    json_trophies.each do |json_trophy|

      json_hash = TrophiesManager.configuration_hash json_trophy

      class_name = json_trophy['type']

      # First, make sure that the class is valid and exists.
      begin
        trophy_type = Object.const_get(class_name)
      rescue
        raise "#{class_name} is not a valid trophy type."
      end

      # Secondly, make sure it is a trophy.
      unless trophy_type < Trophy
        raise "#{class_name} is not a trophy and can't be instantiated."
      end

      trophy_type.raise_on_save_failure = true

      # Creates or get the trophy from the database
      trophy = trophy_type.first_or_create(
        :json_hash => json_hash,
        :name => json_trophy['name'],
      )

      # Configures the trophy
      trophy.configure(json_trophy['configuration'])

      # Updates the description of the trophy
      trophy.update(:description => trophy.to_s)

      @loaded_trophies.push trophy

    end
  end

  def self.configuration_hash json_trophy
    # Given the configuration dictionary, returns the hash
    # to store in the database.
    Digest::SHA256.hexdigest json_trophy.to_json
  end

  def check_for_new_trophies_to_award user

    @loaded_trophies.each do |trophy|
      # If the trophy has not been awarded yet to the user,
      unless TrophyUser.count(:user => user, :trophy => trophy) > 0
        #  then call the trophy's should_be_awarded method.
        if trophy.should_be_awarded user
          #  If it should be awarded to the user,
          #   save it somewhere in the database!
          TrophyUser.create(:user => user, :trophy => trophy)
        end
      end
    end

  end

end
