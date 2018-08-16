class UsersController < ApplicationController
  def edit 
    @user = current_user
  end
  
  private

    def user_params
      params.require(:user).permit(:two_way_authenticated)
    end
end
