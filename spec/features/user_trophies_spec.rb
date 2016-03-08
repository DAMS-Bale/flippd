feature "a user dashboard page trophies" do
  before(:each) do
    @quiz = create_quiz
    sign_in from: ('/')
    visit_dashboard
  end

  context "when no trophies have been unlocked" do
    it "should display a no trophies message" do
      expect(page).to have_content("Trophies: 0");
      expect(page).to have_content(" has not yet been awarded any trophies.");
    end
  end

  context "after viewing a video page" do
    before(:each) do
      visit('/videos/1')
      visit_dashboard
    end

    it "should have unlocked the Learner trophy" do
      expect(page).to have_content("Trophies: 1");
      expect(page).to have_content("Learner - First video watched");
      expect(page).to have_content("Watch at least 1 videos");
    end

    context "then viewing a further 3 video pages" do
      before(:each) do
        visit('/videos/2')
        visit('/videos/3')
        visit('/videos/4')
        visit_dashboard
      end

      it "should continue to show the Learner trophy" do
          expect(page).to have_content("Learner - First video watched");
          expect(page).to have_content("Watch at least 1 videos");
      end

      it "should show the Studying hard trophy" do
          expect(page).to have_content("Trophies: 2");
          expect(page).to have_content("Studying hard");
          expect(page).to have_content("Watch at least 4 videos");
      end
    end
  end

  context "after viewing the set of extensibility videos" do
    before(:each) do
      visit('/videos/28')
      visit('/videos/29')
      visit('/videos/30')
      visit('/videos/31')
      visit_dashboard
    end

    it "should show the Extensible Square Eyes trophy" do
      expect(page).to have_content("Trophies: 3");
      expect(page).to have_content("Extensible Square Eyes");
      expect(page).to have_content("Watch all the videos in the group: 28, 29, 30, 31");
    end
  end

  context "after leaving a comment" do
    before(:each) do
      visit('/videos/1')
      fill_in "Add a comment", with: "This is my comment"
      click_on "Comment"
      visit_dashboard
    end

    it "should show the Young commenter and Learner trophy" do
      expect(page).to have_content("Trophies: 2");
      expect(page).to have_content("Young commenter");
      expect(page).to have_content("Write at least 1 comments");
    end

    context "after leaving a further 4 comments" do
      before(:each) do
        visit('/videos/1')
        fill_in "Add a comment", with: "This is my comment 2"
        click_on "Comment"
        fill_in "Add a comment", with: "This is my comment 3"
        click_on "Comment"
        fill_in "Add a comment", with: "This is my comment 4"
        click_on "Comment"
        visit('/videos/2')
        fill_in "Add a comment", with: "This is my comment 5"
        click_on "Comment"
        visit_dashboard
      end

      it "should show the Talk too much? trophy" do
        expect(page).to have_content("Trophies: 3");
        expect(page).to have_content("Talk too much?");
        expect(page).to have_content("Write at least 5 comments");
      end

      it "should continue to show the Young commenter trophy" do
        expect(page).to have_content("Young commenter");
        expect(page).to have_content("Write at least 1 comments");
      end
    end
  end
end
