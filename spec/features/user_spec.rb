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
      expect(PageView.all.size).to eq(1)
      expect(User.first.page_views.size).to eq(1)
      expect(page).to have_content("Video Views: 1")
      expect(page).to have_content('Ruby true')
    end

    context "twice" do
      before(:each) do
        visit('/videos/1')
        visit_dashboard
      end

      it "should have one video view" do
        expect(PageView.all.size).to eq(1)
        expect(User.first.page_views.size).to eq(1)
        expect(page).to have_content("Video Views: 1")
        expect(page).to have_content('Ruby true')
      end

    end
  end
end

def visit_dashboard
  click_on "user-dropdown"
  click_on "View Dashboard"
end
