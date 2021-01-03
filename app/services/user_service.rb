class UserService

  def self.auth_user(code)
    response = auth_conn.post('/login/oauth/access_token') do |req|
      req.params['client_id'] = ENV["CLIENT_ID"]
      req.params['client_secret'] = ENV["CLIENT_SECRET"]
      req.params['code'] = code
    end

    JSON.parse(response.body, symbolize_names: true)
    # data = JSON.parse(response.body, symbolize_names: true)
    # access_token = data[:access_token]
    # self.session_user(access_token)
  end

  def self.session_user(access_token)
    response = session_conn(access_token).get('/user')
    # data = JSON.parse(response.body, symbolize_names: true)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_repos(access_token)
    response = Faraday.get("https://api.github.com/user/repos", {}, {"Authorization": "token #{access_token}" })

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.auth_conn
    Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})
  end

  def self.session_conn(access_token)
    Faraday.new(
      url: 'https://api.github.com',
      headers: {
        'Authorization': "token #{access_token}"
      }
    )
  end
end
