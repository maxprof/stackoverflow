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
    @question.upvote_from current_user
  end

  def downvote
    @question.downvote_from current_user
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def votes_count(answer)
      @answer = Answer.find(answer.id)
      @votes = @answer.get_upvotes.size - @answer.get_downvotes.size
      return @votes
    end

    def get_answers
      @answers = Answer.where(question_id: @question.id).order('@votes DESC')
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
          flash[:danger] = "it's not tour question, you should have 'moderator' role to do this operation"
          redirect_to questions_path
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
