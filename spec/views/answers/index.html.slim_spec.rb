require 'rails_helper'

RSpec.describe "answers/index", type: :view do
  before(:each) do
    assign(:answers, [
      Answer.create!(
        :user_id => 1,
        :text => "MyText",
        :positive_vote => 2,
        :negative_vote => 3
      ),
      Answer.create!(
        :user_id => 1,
        :text => "MyText",
        :positive_vote => 2,
        :negative_vote => 3
      )
    ])
  end

  it "renders a list of answers" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
