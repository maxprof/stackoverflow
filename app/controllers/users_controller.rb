class UsersController < ApplicationController
  helper_method :get_user_ranking
  before_action :check_rules, only: [:destroy]
  before_action :check_admin_rules, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to (:back), notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User profile was successufly updated"
      redirect_to user_path(@user)
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5).order('@user_ranking DESC')
  end

  private

    def check_rules
      if user_signed_in?
        if current_user.role != "admin" && current_user.id != @user.id
          flash[:success] = "It's not your profile"
          redirect_to (:back)
        end
      else
       flash[:success] = "You not signed in"
       redirect_to root_path
      end
    end

    def check_admin_rules
      if user_signed_in?
        if current_user.role != "admin"
          flash[:success] = "You have no rights"
          redirect_to (:back)
        end
      else
       flash[:success] = "You not signed in"
       redirect_to (:back)
      end
    end

    def get_user_ranking(user)
      @user = User.find(user.id)
      @answers = @user.answers
      @user_ranking = 0
        @answers.each do |answer|
          @user_ranking += (answer.get_upvotes.size - answer.get_downvotes.size)
        end
      @questions = @user.questions
        @questions.each do |question|
          @user_ranking += (question.get_upvotes.size - question.get_downvotes.size)
        end
      return @user_ranking
    end

    def user_params
       params.require(:user).permit(:email, :avatar, :login, :country, :date_of_birth, :city, :address)
    end
end



