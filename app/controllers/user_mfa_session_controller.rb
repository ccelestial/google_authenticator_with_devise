class UserMfaSessionController < ApplicationController
  skip_before_action :check_mfa

  def new
  end

  def create
    if current_user.google_authentic?(mfa_code)
       UserMfaSession.create(current_user)
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
