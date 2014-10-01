class GitHub

    CLIENT_ID = ENV['GITHUB_CLIENT_ID']
    CLIENT_SECRET = ENV['GITHUB_CLIENT_SECRET']

    OAUTH_BEGIN_URL = 'https://github.com/login/oauth/authorize'

    OAUTH_TOKEN_URL = 'https://github.com/login/oauth/access_token'

    REQUESTED_SCOPES = [
        'user:follow'
    ]

    BASE_URI = 'https://api.github.com'

    attr_accessor :token

    def initialize redirect_uri
        @redirect_uri = redirect_uri
    end

    def begin_url
        OAUTH_BEGIN_URL + '?' + {
            client_id: CLIENT_ID,
            # use _url instead of _path so it generates the full host + path,
            # not just /github/code
            redirect_uri: @redirect_uri,
            scope: REQUESTED_SCOPES.join(',')
        }.to_query
    end

    def get_token code
        response = Typhoeus.post OAUTH_TOKEN_URL,
            params: {
                client_id: CLIENT_ID,
                client_secret: CLIENT_SECRET,
                code: code
            },
            headers: { Accept: 'application/json' }

        JSON.parse response.body
    end

    def follow_user username
        req = general_request :put, 'user/following/' + username

        p req

        req.run
    end

    def get_my_info
        make_request 'user'
    end

    def get_my_following
        make_request 'user/following'
    end

    private

    def make_request endpoint
        req = general_request :get, endpoint

        response = req.run

        JSON.parse response.body
    end

    def general_request req_method, endpoint
        options = {
            method: req_method,
            headers: {
                Authorization: 'token ' + @token
            }
        }

        if req_method == :put
            options[:headers]['Content-Length'] = 0
        end

        url = BASE_URI + '/' + endpoint

        request = Typhoeus::Request.new url, options
    end

end
