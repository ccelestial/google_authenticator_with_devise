class AuthenticationsController < ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(authentication_params)
      check_existing_qr

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

    def check_existing_qr
      # if there is no existing google secret, create it
      # it means that it is the first time the user
      # activated two factor authentication
      # Add Google secret for capturing
      @user.set_google_secret unless @user.google_secret
      # Added to session
      UserMfaSession.create(@user)
    end
end
