feature "a user dashboard page trophies" do
  before(:each) do
    sign_in from: ('/')
    visit_dashboard
  end

  context "when no trophies have been unlocked" do
    it "should display a no trophies message" do
      expect(page).to have_content("Trophies: 0");
      expect(page).to have_content(" has not yet been awarded any trophies.");
    end
  end

  context "after viewing a page" do
    before(:each) do
      visit('/videos/1')
      visit_dashboard
    end

    it "should have unlocked the Learner trophy" do
      expect(page).to have_content("Trophies: 1");
      expect(page).to have_content("Learner - First video watched");
      expect(page).to have_content("Watch at least 1 videos");
    end

  end
end
