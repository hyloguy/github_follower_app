class SessionsController < ApplicationController

	def create
		@user = User.find_by :username => params[:username]

		# Old way
		# if @user.password_matches?(params[:password])
		if @user.authenticate params[:password]
			session[:current_user_id] = @user.id
			render :plain => "Hooray!"
		else
			render :plain => "Nope!"
		end
	end

end