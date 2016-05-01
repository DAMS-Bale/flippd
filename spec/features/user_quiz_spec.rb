feature "a user dashboard page quiz results" do
  before(:each) do
    sign_in from: ('/')
    visit_dashboard
  end

  context "where a quiz exists" do
    before(:each) do
      @q = create_quiz
    end

    context "after getting 0%" do
      before(:each) do
        visit('/quiz/' + @q[:quiz].id.to_s)
        choose @q[:answer1_2].id
        click_on "Mark"
        visit_dashboard
      end

      it "should have the result listed" do
        expect(page).to have_content(
          "#{@q[:quiz].name} 0.0% 0 / 1 #{DateTime.now.strftime("%d/%m/%Y")}")
      end

      it "should have awarded no points for the quiz" do
        expect(page).to have_content("0 Points")
      end

      context "after getting 100%" do
        before(:each) do
          visit('/quiz/' + @q[:quiz].id.to_s)
          choose @q[:answer1_1].id
          @time100 = DateTime.now
          click_on "Mark"
          visit_dashboard
        end

        it "should have the best result listed" do
          expect(page).to have_content(
            "#{@q[:quiz].name} 100.0% 1 / 1 #{@time100.strftime("%d/%m/%Y  %H:%M")}")
        end

        it "should have awarded a point for the correct answer" do
          expect(page).to have_content("1 Points")
        end

        context "after getting 0% again" do
          before(:each) do
            visit('/quiz/' + @q[:quiz].id.to_s)
            choose @q[:answer1_2].id
            click_on "Mark"
            visit_dashboard
          end

          it "should continue listing the best result" do
            expect(page).to have_content(
              "#{@q[:quiz].name} 100.0% 1 / 1 #{@time100.strftime("%d/%m/%Y  %H:%M")}")
          end

          it "should have still awarded a point for the correct answer" do
            expect(page).to have_content("1 Points")
          end
        end
      end
    end

  end
end
