feature "a user dashboard page video views" do
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
end
