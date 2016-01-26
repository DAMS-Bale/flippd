feature "A quiz" do
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
  end

  describe("page view") do
    before(:each) do
      visit('/phases/fundamentals')
    end

    it "contains the quiz name" do
      within('body') do
        quiz1 = Quiz.get(2)
        expect(page).to have_content quiz1.name
      end
    end


    context "after opening the quiz page" do

      before(:each) do
        visit('/quiz/' + @quiz.id.to_s)
      end

      it "contains both the questions" do
        within('body') do
          expect(page).to have_content 'How old am I?'
          expect(page).to have_content 'What\'s my name?'
        end
      end

      it "contains all the answers" do
        within('body') do
          expect(page).to have_content 'Twenty'
          expect(page).to have_content 'Fifteen'
          expect(page).to have_content 'Alice'
          expect(page).to have_content 'Bob'
        end
      end

      context "marking" do
        before(:each) do
          check @answer1_1.id
          check @answer1_2.id
          check @answer2_1.id
          uncheck @answer2_2.id
        end

        it "submits the response" do
          click_on "Mark"
        end
      end
    end
  end


  context "marking" do
    before(:each) do
      @header = {'Content-Type' => 'application/json'}
      @body = { :answers => [] }.to_json
      @route = "/quiz/" + @quiz.id.to_s + "/mark"
    end

    it "is a valid route" do
      post @route, @body, @header
    end
  end
  context "single-selection" do
    before(:each) do
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
      visit('/quiz/' + @quiz3.id.to_s)
    end
    it "single correct answer" do
      check @answer3_1.id
      click_on "Mark"
      #TODO Add expect condition
    end
    it "single incorrect answer" do
      check @answer3_2.id
      click_on "Mark"
      #TODO Add expect condition
    end
  end


end
