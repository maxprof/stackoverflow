class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :check_rules, only: [:new, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    redirect_to(:back)
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
        format.js
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @answer.upvote_from current_user, :vote_weight =>  1
    respond_to do |format|
      format.js
    end
  end

  def downvote
    @answer.downvote_from current_user, :vote_weight => -1
    format.js
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:user_id, :text, :positive_vote, :negative_vote, :question_id)
    end

    def check_rules
      if user_signed_in?
        @user = current_user
        if  @user.role != "moder" && @answer.user_id != current_user.id
          flash[:danger] = "it's not tour question, you should have 'moderator' role to do this operation"
          redirect_to questions_path
        elsif @user.role == nil and @answer.user_id != @user.id
          flash[:danger] = "It's not your answer"
          redirect_to questions_path
        end
      else
        flash[:danger] = "You dont signed in to do this operation"
        redirect_to questions_path
      end
    end

end
