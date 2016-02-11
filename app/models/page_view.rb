# This model represents a page view by a user, such as for when a video is viewed.
class PageView
  include DataMapper::Resource

  property :id, Serial

  property :route, String, :required => true

  belongs_to :user

  property :timestamp, DateTime, required: true, default: lambda{
    |p,s| DateTime.now
  }

end
