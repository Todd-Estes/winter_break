class DashboardController < ApplicationController

 def show
   @user_repos = UserFacade.user_repos(current_user.token)
 end
end
