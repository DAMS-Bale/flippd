# A simple linear comment system for each video.
class Comment
  include DataMapper::Resource

  property :id, Serial
  property :videoId, Integer, required: true
  property :videoTime, Integer, required: false
  # Using a Lambda to make sure this gets evaluated at creation time
  property :commentTime, DateTime, required: true, default: lambda{
    |p,s| DateTime.now
  }
  property :lastEditTime, DateTime, required: false
  property :text, String, length: 1024, required: false

  # Association to the author (user), last editor (user) and parent comment
  belongs_to :user
  belongs_to :lastEditUser, 'User', required: false
  belongs_to :parent, 'Comment', required: false

  # Not needed for this basic linear structure, instead create new comments for
  # the video
  # Adds a reply to this comment, and returns the new comment.
  # def add_reply user, text
  #   Comment::create(
  #     :parent       =>  self,
  #     :videoId      =>  @videoId,
  #     :text         =>  text,
  #     :user         =>  user
  #   )
  # end

  # Returns the video time as a Time object, if any
  def video_time
    @videoTime.nil? ? nil : Time.at(@videoTime)
  end

  # Edits this comment and updates last editor and last edit timestamp
  def edit_comment user, new_text
    update(
      :lastEditUser => user,
      :lastEditTime => DateTime.now,
      :text => new_text,
    )
  end

  # Deletes the comment (updating the text to an empty string)
  def delete_comment user
    edit_comment user, nil
  end

  # Edits the video timestamp of the comment
  def edit_video_time new_video_time
    update(
      :videoTime => new_video_time
    )
  end

end
