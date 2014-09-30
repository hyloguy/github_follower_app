class GithubController < ApplicationController

    GITHUB_CLIENT_ID = ENV['GITHUB_CLIENT_ID']
    GITHUB_CLIENT_SECRET = ENV['GITHUB_CLIENT_SECRET']

    GITHUB_OAUTH_BEGIN_URL = 'https://github.com/login/oauth/authorize'

    GITHUB_OAUTH_TOKEN_URL = 'https://github.com/login/oauth/access_token'

    def begin
        redirect_to GITHUB_OAUTH_BEGIN_URL + '?' + {
            client_id: GITHUB_CLIENT_ID,
            # use _url instead of _path so it generates the full host + path,
            # not just /github/code
            redirect_uri: github_code_url
        }.to_query
    end

    def code
        @code = params[:code]

        @response = Typhoeus.post GITHUB_OAUTH_TOKEN_URL,
            params: {
                client_id: GITHUB_CLIENT_ID,
                client_secret: GITHUB_CLIENT_SECRET,
                code: @code
            },
            headers: { Accept: 'application/json' }

        p @response
        results = JSON.parse @response.body
        puts
        p results

        current_user.github_token = results['access_token']
        current_user.save!

        redirect_to root_path
    end

end
