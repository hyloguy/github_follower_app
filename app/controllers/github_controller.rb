class GithubController < ApplicationController

    def begin
        redirect_to @github.begin_url
    end

    def code
        results = @github.get_token params[:code]

        p results

        current_user.github_token = results['access_token']
        current_user.save!

        redirect_to root_path
    end

    def follow
        results = @github.follow_user params[:username]

        if results.body.empty?
            flash[:notice] = 'User followed successfully!'
        else
            flash[:error] = results.body
        end

        redirect_to root_path
    end

end
