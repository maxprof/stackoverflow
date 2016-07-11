class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]
  helper_method :get_user_ranking
  before_action :check_rules, only: [:destroy, :show]
  before_action :check_admin_rules, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User was successufly created"
      redirect_to(:back)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "User profile was successufly updated"
      redirect_to user_path(@user)
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

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
        if current_user.role != "admin" && current_user.role != nil
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
       params.require(:user).permit(:email, :avatar, :login, :country, :date_of_birth, :city, :address, :role)
    end
end



