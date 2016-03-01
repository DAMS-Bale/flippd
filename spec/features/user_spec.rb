feature "a user dashboard page" do
  before(:each) do
    sign_in from: ('/')
    visit_dashboard
  end

  context "after viewing a page" do
    before(:each) do
      visit('/videos/1')
      visit_dashboard
    end

    it "should have a page view" do
      expect(VideoView.all.size).to eq(1)
      expect(User.first.video_views.size).to eq(1)
      expect(page).to have_content("Video Views: 1")
      expect(page).to have_content('Ruby true')
      expect(page).to have_content('5 Points')
    end

    context "twice" do
      before(:each) do
        visit('/videos/1')
        visit_dashboard
      end

      it "should have one video view" do
        expect(VideoView.all.size).to eq(1)
        expect(User.first.video_views.size).to eq(1)
        expect(page).to have_content("Video Views: 1")
        expect(page).to have_content('Ruby true')
        expect(page).to have_content('5 Points')
      end

    end
  end

  context "where a quiz exists" do
    before(:each) do
      @quiz = Quiz::create(
        :id      => 1,
        :name    => "My quiz"
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
    end

    context "after getting 0%" do
      before(:each) do
        visit('/quiz/' + @quiz.id.to_s)
        choose @answer1_2.id
        click_on "Mark"
        visit_dashboard
      end

      it "should have the result listed" do
        expect(page).to have_content(
          "#{@quiz.name} 0.0% 0 / 1 #{DateTime.now.strftime("%d/%m/%Y")}")
      end

      context "after getting 100%" do
        before(:each) do
          visit('/quiz/' + @quiz.id.to_s)
          choose @answer1_1.id
          click_on "Mark"
          visit_dashboard
        end

        it "should have the best result listed" do
          expect(page).to have_content(
            "#{@quiz.name} 100.0% 1 / 1 #{DateTime.now.strftime("%d/%m/%Y")}")
        end
      end
    end

  end
end

def visit_dashboard
  click_on "user-dropdown"
  click_on "View Dashboard"
end
