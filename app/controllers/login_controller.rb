class LoginController < ApplicationController

#see layout
#layout = "admin"

def add_employee
end

def login
   if request.get?
      session[:user_id] = nil
      @user = Employee.new
   else
      @user = Employee.new(params[:user])
      logged_in_user = @user.try_to_login
      if logged_in_user
	session[:user_id] = logged_in_user.id
        # add the user name to the session.
        session[:user_name] = logged_in_user.first_name
	redirect_to(:controller => "maxom", :action => "index")
      else
	flash[:notice] = "Invalid user/password combo."
      end
   end
end

def logout
    session[:user_id] = nil
    session = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
end

def del_employee
end

def list_employees
end

end
