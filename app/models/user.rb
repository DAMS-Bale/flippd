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

  # Manually set whether the user is a lecturer, overriding the default check
  #def override_lecturer new_lecturer
  #  update(:lecturer => new_lecturer)
  #end

end
