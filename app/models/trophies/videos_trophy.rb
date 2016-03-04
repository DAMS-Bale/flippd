# A trophy of this type can be awarded to an user when
# they have watched a given number of videos.
class VideosTrophy < Trophy

  def configure params
    @number_of_videos = params['videos']
  end

  def should_be_awarded user
    VideoView.count(:user => user) > @number_of_videos
  end

  def to_s
    "Watch at least #{@number_of_videos} videos"
  end

end
