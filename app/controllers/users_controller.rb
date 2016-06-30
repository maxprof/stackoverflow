class UsersController < ApplicationController
  helper_method :get_user_ranking
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
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



