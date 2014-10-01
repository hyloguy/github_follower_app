class UsersController < ApplicationController

    def index
        if github_connected?
            @github_user = @github.get_my_info
            @github_following = @github.get_my_following
        end
    end

    def create
        @user = User.new user_params

        if @user.save
            flash[:notice] = "Your account has been created! Please login."
            redirect_to root_path
        else
            # Re-render the template that led here. Errors will be displayed
            # because there is a @user instance variable now.
            render :index
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :username,
            :password,
            :password_confirmation
        )
    end

end
