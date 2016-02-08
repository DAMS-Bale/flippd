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
          choose @answer1_1.id
          choose @answer2_2.id
        end

        it "submits the response" do
          click_on "Mark"
        end
      end
    end

    context "after opening the single-selection quiz page" do
      before(:each) do
        visit('/quiz/' + @quiz3.id.to_s)
      end
      it "single correct answer" do
        choose @answer3_1.id
        click_on "Mark"
        #TODO Add expect condition
      end
      it "single incorrect answer" do
        choose @answer3_2.id
        click_on "Mark"
        #TODO Add expect condition
      end
    end
  end




end
