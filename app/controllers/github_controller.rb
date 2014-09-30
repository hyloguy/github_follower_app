require 'github_api'

class GithubController < ApplicationController

    def begin
        redirect_to GitHub.begin_url(github_code_url)
    end

    def code
        results = GitHub.get_token params[:code]

        p results

        current_user.github_token = results['access_token']
        current_user.save!

        redirect_to root_path
    end

end
