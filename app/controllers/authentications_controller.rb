class AuthenticationsController < ApplicationController
  skip_before_action :check_mfa

  def show
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(authentication_params)
      # Add Google secret for capturing
      @user.set_google_secret
      # Added to session
      UserMfaSession.create(@user)
      redirect_to authentications_url
    else
      flash[:error] = "Something went wrong."
      redirect_to authentications_url
    end
  end

  private

    def authentication_params
      {
        two_factor_authenticated: params[:two_factor_authenticated].present?
      }
    end

end
