class Flippd < Sinatra::Application
  get '/videos/:id' do
    # Save the video page view if logged in.
    if @user then
      PageView.first_or_create(:route => ('/videos/' + params['id']), :user => @user)
    end

    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == params['id'].to_i
            @phase = phase
            @video = video
            @comments = Comment.all(:videoId => @video["id"])
          end
        end
      end
    end

    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == params['id'].to_i + 1
            @next_video = video
          end
        end
      end
    end

    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == params['id'].to_i - 1
            @previous_video = video
          end
        end
      end
    end

    pass unless @video
    erb :video
  end
end
