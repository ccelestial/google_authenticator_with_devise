class UserMfaSessionController < ApplicationController
  skip_before_action :check_mfa

  def new
  end

  def create
    user = current_user
    if user.google_authentic?(mfa_code)
       UserMfaSession.create(user)
       redirect_to root_path
    else
      flash[:error] = "Wrong code"
      render :new
    end
  end

  private

    def mfa_code
      params[:mfa_code]
    end
end
