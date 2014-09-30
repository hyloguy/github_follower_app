class GitHub

    CLIENT_ID = ENV['GITHUB_CLIENT_ID']
    CLIENT_SECRET = ENV['GITHUB_CLIENT_SECRET']

    OAUTH_BEGIN_URL = 'https://github.com/login/oauth/authorize'

    OAUTH_TOKEN_URL = 'https://github.com/login/oauth/access_token'

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
            redirect_uri: @redirect_uri
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

    def make_request endpoint
        response = Typhoeus.get BASE_URI + '/' + endpoint,
            headers: {
                Authorization: 'token ' + @token
            }

        JSON.parse response.body
    end

end
