class HomeController < ApplicationController
  helper_method :votes_count
  def index
    @questions = Question.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  def votes_count(question)
    @question = Question.find(question.id)
    @votes = @question.get_upvotes.size - @question.get_downvotes.size
    return @votes
  end
end
