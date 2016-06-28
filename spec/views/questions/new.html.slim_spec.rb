require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      :user_id => 1,
      :positive_vote => 1,
      :negative_vote => 1,
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input#question_user_id[name=?]", "question[user_id]"

      assert_select "input#question_positive_vote[name=?]", "question[positive_vote]"

      assert_select "input#question_negative_vote[name=?]", "question[negative_vote]"

      assert_select "input#question_title[name=?]", "question[title]"

      assert_select "textarea#question_description[name=?]", "question[description]"
    end
  end
end
