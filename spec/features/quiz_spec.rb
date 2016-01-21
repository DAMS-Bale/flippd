feature "The quiz route" do
  before(:each) do

    @quiz = Quiz::create(
      :name    => "Test Quiz 1",
    )
  end

  context "marking" do
    it "is a valid route" do
      post "/quiz/" + @quiz.id.to_s + "/mark", :answers => []
    end
  end
end
