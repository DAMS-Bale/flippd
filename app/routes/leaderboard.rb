class Flippd < Sinatra::Application

  before '/leaderboard' do
    unless @user
      halt 401, "Error 401, Unauthorised"
    end
  end

  get '/leaderboard' do

    @leaderboard = repository.adapter.select("
      SELECT
        users.id as user_id,
        users.name as user_name,
        SUM(best_scores.score) as user_score
      FROM
        (
          SELECT quiz_id, score, user_id
          FROM   quiz_results AS q1 INNER JOIN users
            ON   q1.user_id = users.id
          WHERE  users.share_results = true
            AND  score = (
              SELECT
                MAX(q2.score)
              FROM
               quiz_results AS q2
              WHERE q2.quiz_id = q1.quiz_id
                AND q2.user_id = q1.user_id
            )
          GROUP BY    quiz_id, user_id
          ORDER BY    score DESC
        ) as best_scores
          INNER JOIN users
            ON best_scores.user_id = users.id
      GROUP BY  users.id
      ORDER BY  user_score DESC
    ")

    erb :leaderboard

  end

  get '/leaderboard/switch' do
    @user.share_results = !@user.share_results
    @user.save
    redirect to('/leaderboard')
  end



end
