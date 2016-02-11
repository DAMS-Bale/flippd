feature "The leaderboard" do
  before(:each) do

    @quiz = Quiz::create(
      :name    => "My quiz"
    )

    @quiz2 = Quiz::create(
      :name    => "My second quiz"
    )

    @question1 = Question::create(
      :quiz   =>  @quiz,
      :text   =>  "What's my name?"
    )

    @answer1_1 = Answer::create(
      :question => @question1,
      :text     => "Alice",
      :correct  => true
    )

    @answer1_2 = Answer::create(
      :question => @question1,
      :text     => "Bob",
      :correct  => false
    )

    @question2 = Question::create(
      :quiz   =>  @quiz,
      :text   =>  "How old am I?"
    )


    @answer2_1 = Answer::create(
      :question => @question2,
      :text     => "Fifteen",
      :correct  => true
    )

    @answer2_2 = Answer::create(
      :question => @question2,
      :text     => "Twenty",
      :correct  => false
    )

    @quiz3 = Quiz::create(
      :name    => "Single Question Quiz"
    )

    @question3_1 = Question::create(
      :quiz   =>  @quiz3,
      :text   =>  "Correct Answer is 1?"
    )

    @answer3_1 = Answer::create(
      :question => @question3_1,
      :text     => "Alice",
      :correct  => true
    )

    @answer3_2 = Answer::create(
      :question => @question3_1,
      :text     => "Bob",
      :correct  => false
    )

    @user1 = User::create(
      :name     => "Mark",
      :email    => "mark.ross@york.ac.uk",
      :lecturer => false,
      :share_results => false
    )

    @result1 = QuizResult::create(
      :user     =>  @user1,
      :quiz     =>  @quiz,
      :score    =>  0,
    )

    @result2 = QuizResult::create(
      :user     =>  @user1,
      :quiz     =>  @quiz,
      :score    =>  1,
    )

    sign_in name: @user1.name, email: @user1.email
  end

  after(:each) do
    @quiz.destroy
    @quiz2.destroy
  end

  describe("page view") do
    before(:each) do
      visit('/leaderboard')
    end

    it "does open correctly" do
      within('body') do
        expect(page).to have_content "Leaderboard"
      end
    end

    it "is does not contain any result for privacy" do
      within('body') do
        expect(page).to have_no_content "Mark"
      end
    end

    context "after changing the privacy preference" do
      before(:each) do

        visit('/leaderboard/switch')
        visit('/leaderboard')
      end

      it "now has the result" do
        within('body') do
          expect(page).to have_content "Mark"
        end
      end

      it "has the correct score" do
        within('body') do
          expect(page).to have_content "1"
        end
      end


    end

  end

end
