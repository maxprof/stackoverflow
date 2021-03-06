class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :upvote,:downvote]
  before_action :check_rules, only: [:edit, :update, :destroy]
  helper_method :votes_count
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    if @question.visitors == nil
      @question.visitors = 0
      @question.increment(:visitors, 1)
      @question.save
    else
      @question.increment(:visitors, 1)
      @question.save
    end
    get_answers
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  def upvote
    @question.upvote_from current_user, :vote_weight =>  1
    redirect_to(:back)
  end

  def downvote
    @question.downvote_from current_user, :vote_weight => -1
    redirect_to(:back)
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success]= 'Question was successfully created.'
      redirect_to @question
    else
      render 'new'
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if @question.update(question_params)
      flash[:success] = "Question was successufly updated"
      redirect_to question_path(@question)
    else
      render 'edit'
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    flash[:success] = "Question was successfully destroyed."
    redirect_to questions_url
  end

  private

    def votes_count(answer)
      @answer = Answer.find(answer.id)
      @votes = @answer.get_upvotes.size - @answer.get_downvotes.size
      return @votes
    end

    def get_answers
      @answers = Answer.where(question_id: @question.id).order('cached_weighted_total DESC')
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:user_id, :positive_vote, :negative_vote, :title, :description, tag_ids: [])
    end

    def check_rules
      if user_signed_in?
        @user = current_user
        if  @user.role != "moder" && @question.user_id != current_user.id
          flash[:danger] = "it's not your question, you should have 'moderator' role to do this operation"
          redirect_to root_path
        elsif @user.role == nil && @question.user_id != @user.id
          flash[:danger] = "It's not your question"
          redirect_to questions_path
        end
      else
        flash[:danger] = "You dont signed in to do this operation"
        redirect_to questions_path
      end
    end
end
