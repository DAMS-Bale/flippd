# A trophy of this type can be awarded to a user if they
# watched all videos in a given group of videos
class VideosGroupTrophy < Trophy

  def configure params
    @video_ids = params['videos']
  end

  def should_be_awarded user
    @video_ids.each do |video_id|
      unless VideoView.count(:user => user, :video_id => video_id) > 0
        return false
      end
    end
    true
  end

  def to_s
    all_videos = @video_ids.join ", "
    "Watch all the videos in the group: #{all_videos}"
  end

end
