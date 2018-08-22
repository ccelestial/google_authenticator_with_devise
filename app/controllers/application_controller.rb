class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_mfa

  private

  def check_mfa
    if current_user && current_user.mfa_authenticated?
      if !(user_mfa_session = UserMfaSession.find) &&
        (user_mfa_session ? user_mfa_session.record == current_user : !user_mfa_session)
        redirect_to new_user_mfa_session_path
      end
    end
  end
end
