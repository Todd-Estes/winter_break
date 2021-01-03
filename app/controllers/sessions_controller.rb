class SessionsController < ApplicationController

  def create
    # client_id = ENV["CLIENT_ID"]
    # client_secret = ENV["CLIENT_SECRET"]
    # code = params[:code]

    auth = UserService.auth_user(params[:code])
    access_token = auth[:access_token]
    data = UserService.session_user(access_token)



    # conn = Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})
    #
    # response = conn.post('/login/oauth/access_token') do |req|
    #   req.params['code'] = ENV["CLIENT_ID"]
    #   req.params['client_id'] = ENV["CLIENT_SECRET"]
    #   req.params['client_secret'] = params[:code]
    # end



    # data = JSON.parse(response.body, symbolize_names: true)
    # access_token = data[:access_token]


    # conn = Faraday.new(
    #
    #   url: 'https://api.github.com',
    #   headers: {
    #     'Authorization': "token #{access_token}"
    #   }
    # )
    # response = conn.get('/user')
    # data = JSON.parse(response.body, symbolize_names: true)

    user          = User.find_or_create_by(uid: data[:id])
    user.username = data[:login]
    user.uid      = data[:id]
    user.token    = access_token
    user.save

    session[:user_id] = user.id

    redirect_to dashboard_path
  end
end
