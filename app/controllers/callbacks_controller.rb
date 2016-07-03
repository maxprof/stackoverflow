class CallbacksController < Devise::OmniauthCallbacksController

    def vkontakte
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
      		flash[:success] = "You are succsessfuly logged in"
            sign_in_and_redirect @user
        else
            flash[:danger] = "authentication error"
            redirect_to root_path
        end
    end

    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
          	flash[:success] = "You are succsessfuly logged in"
            sign_in_and_redirect @user
        else
            flash[:danger] = "authentication error"
            redirect_to root_path
        end
    end

    def twitter
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
            flash[:success] = "You are succsessfuly logged in"
            sign_in_and_redirect @user
        else
            flash[:danger] = "authentication error"
            redirect_to root_path
        end
    end

end
