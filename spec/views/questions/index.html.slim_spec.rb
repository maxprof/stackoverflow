require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :user_id => 1,
        :positive_vote => 2,
        :negative_vote => 3,
        :title => "Title",
        :description => "MyText"
      ),
      Question.create!(
        :user_id => 1,
        :positive_vote => 2,
        :negative_vote => 3,
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
