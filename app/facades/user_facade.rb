class UserFacade

  def self.user_repos(code)
    user_data = UserService.get_repos(code)
    user_data.map do |data|
      UserData.new(data)
    end
  end
end
