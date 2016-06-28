require 'rails_helper'

RSpec.describe "answers/new", type: :view do
  before(:each) do
    assign(:answer, Answer.new(
      :user_id => 1,
      :text => "MyText",
      :positive_vote => 1,
      :negative_vote => 1
    ))
  end

  it "renders new answer form" do
    render

    assert_select "form[action=?][method=?]", answers_path, "post" do

      assert_select "input#answer_user_id[name=?]", "answer[user_id]"

      assert_select "textarea#answer_text[name=?]", "answer[text]"

      assert_select "input#answer_positive_vote[name=?]", "answer[positive_vote]"

      assert_select "input#answer_negative_vote[name=?]", "answer[negative_vote]"
    end
  end
end
