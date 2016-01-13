# A user that has logged in to the system, used for authorisation and to
# present comments' authors.
class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true, length: 150
  property :email, String, required: true, length: 150
  property :lecturer, Boolean, allow_nil:true

  def is_lecturer
    #check for  a dot before the @
    if lecturer.nil?
      return email.partition("@").first.include? '.'
    else
      return lecturer
    end
  end

  def can_edit_comment comment
    return is_lecturer || comment.user == self
  end

end
