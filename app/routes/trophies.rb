class Flippd < Sinatra::Application

  after do
    unless @user.nil?
      @trophies.check_for_new_trophies_to_award @user
    end
  end

end
