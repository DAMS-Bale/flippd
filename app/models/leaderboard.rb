# This represents the Leaderboard
class Leaderboard

  def users
    # Gets the users for consideration in the leaderboard.
    User.all
  end

  def results
    leaderboard = []
    for user in users
      leaderboard += [{:user => user, :score => user.total_score}]
    end
    leaderboard.sort_by {|i| i[:score]}
  end

end
