require 'rails_helper'
include Devise::TestHelpers

RSpec.describe QuestionsController, type: :controller do

  def self.it_renders_404_page_when_question_is_not_found(*actions)
    actions.each do |a|
      it "#{a} renders 404 page when questions is not found" do
        verb = if a == :update
          "PATCH"
        elsif a == :destroy
          "DELETE"
        else
          "GET"
        end
        user = FactoryGirl.create(:user, role: "moder")
        sign_in user
        # process a, verb, {id: 0}
        # expect(process a, verb, {id: 0}).to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

it_renders_404_page_when_question_is_not_found :show, :edit, :update, :destroy

  describe "Show action" do

    it "renders show template if an item is found" do
      user = User.create
      question = FactoryGirl.create(:question, user_id: user.id)
      get :show, {id: question.id}
      response.should render_template('show')
    end

  end


  describe "Create action" do

    it "redirects to show page if errors empty" do
      user = User.create
      post :create, question: { title: "Test title", description: "Test desription", user_id: user.id }
      expect(response).to redirect_to(assigns(:question))
    end

    it "redirects to new page if errors presence" do
     user = User.create
     post :create, question: { title: nil, description: "Test desription", user_id: user.id }
     expect(response).to render_template('new')
    end
  end

  describe "Destroy action" do
    it "redirects to questions page when is destroyed successfully" do
      user = User.create
      sign_in user
      question = FactoryGirl.create(:question, user_id: user.id)
      delete :destroy, id: question.id
    response.should redirect_to(questions_path)
    end

    it "redirects to root_path if destroy not current user and not moderator" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      question = FactoryGirl.create(:question, user_id: user.id)
      sign_in user2
      delete :destroy, id: question.id
    response.should redirect_to(root_path)
    end

    it "redirects to questions_path if current user is moderator" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user, role: "moder")
      question = FactoryGirl.create(:question, user_id: user.id)
      sign_in user2
      delete :destroy, id: question.id
    response.should redirect_to(questions_path)
    end
  end

  describe "Edit action" do


  end

end
