class CallbacksController < Devise::OmniauthCallbacksController
	
    def vkontakte
        @user = User.from_omniauth(request.env["omniauth.auth"])
  		flash[:success] = "You are succsessfuly logged in"
        sign_in_and_redirect @user
    end

    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
  		flash[:success] = "You are succsessfuly logged in"
        sign_in_and_redirect @user
    end
    
end 