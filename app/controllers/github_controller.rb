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

end
