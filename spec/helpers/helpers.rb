module Helpers
  def sign_in(from: '/', name: "Joe Bloggs", email: "joe@bloggs.com")
    OmniAuth.config.test_mode = false
    visit from
    click_on 'Sign In' if page.has_link?('Sign In')

    fill_in 'Name', with: name
    fill_in 'Email', with: email
    click_on 'Sign In'
  end


  def sign_in_lecturer(from: '/')
    OmniAuth.config.test_mode = false
    visit from
    click_on 'Sign In' if page.has_link?('Sign In')

    fill_in 'Name', with: 'Joe Bloggs'
    fill_in 'Email', with: 'joe.bloggs@york.ac.uk'
    click_on 'Sign In'
  end

  def fail_to_sign_in(from: '/')
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:developer] = 'Invalid credentials'.to_sym
    visit from
    click_on 'Sign In' if page.has_link?('Sign In')
  end

  def sign_out
    click_on 'Sign Out'
  end

  def visit_dashboard
    click_on "user-dropdown"
    click_on "View Dashboard"
  end

  def create_quiz
    return_val = {}
    return_val[:quiz] = Quiz::first_or_create(
      :id      => 1,
      :name    => "My quiz"
    )
    return_val[:question1] = Question::first_or_create(
      :quiz   =>  return_val[:quiz],
      :text   =>  "What's my name?"
    )
    return_val[:answer1_1] = Answer::first_or_create(
      :id       => 1,
      :question => return_val[:question1],
      :text     => "Alice",
      :correct  => true
    )
    return_val[:answer1_2] = Answer::first_or_create(
      :id       => 2,
      :question => return_val[:question1],
      :text     => "Bob",
      :correct  => false
    )
    return return_val
  end

end

OmniAuth.config.logger.level = Logger::UNKNOWN
