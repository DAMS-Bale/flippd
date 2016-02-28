# This represents the Leaderboard
class Leaderboard

  def self.users
    # Gets the users for consideration in the leaderboard.
    User.all(
      :share_results => true
    )
  end

  def self.results
    leaderboard = []
    for user in Leaderboard.users
      leaderboard += [{:user => user, :score => user.total_score}]
    end
    leaderboard.sort_by {|i| i[:score]}
  end

end
