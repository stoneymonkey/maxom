# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.
class ApplicationController < ActionController::Base



private
   def redirect_to_index(msg = nil)
	flash[:notice] = msg if msg
	redirect_to(:action => "index")
   end

def authorize
  unless session[:user_id]
     flash[:notice] = "Please log in"
     redirect_to(:controller => "login", :action => "login")
  end
end



end