
feature "The quiz route" do
  before(:each) do
    @quiz = Quiz::create(
      :name    => "Test Quiz 1",
    )
  end

  context "marking" do
    it "is a valid route" do
      header = {'Content-Type' => 'application/json'}
      body = { :answers => [] }.to_json
      post "/quiz/" + @quiz.id.to_s + "/mark", body, header
    end
  end
end
