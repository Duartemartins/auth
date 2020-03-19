class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private
  # Make the current_user method available to views also, not just controllers:
  helper_method :current_user

  # Define the current_user method:
def current_user
# Look up the current user based on user_id in the session cookie:
#TIP: The ||= part ensures this helper doesn't hit the database every time a user hits a web page. It will look it up once, then cache it in the @current_user variable.
#This is called memoization and it helps make our app more efficient and scalable.
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def authorize
  redirect_to login_url, alert: "Not authorized" if current_user.nil?
end
end
