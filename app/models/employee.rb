class Employee < ActiveRecord::Base

   attr_accessor :password
   attr_accessible :first_name, :password
   validates_uniqueness_of :ss_id
   validates_presence_of :first_name, :last_name, :password, :ss_id, :home_phone, :cell_phone

   def add_user
      if request.get?
	@user = Employee.new
      else
	@user = Employee.new(params[:user])
	if @user.save
	   redirect_to_index("Employee #{@user.first_name} created")
	end
      end
   end

   def before_create
      self.hashed_password = Employee.hash_password(self.password)
   end

   def after_create
      @password = nil
   end

   def self.hash_password(password)
      Digest::SHA1.hexdigest(password)
   end 

   def getUsers
      Employee
   end

   def try_to_login
      Employee.login(self.first_name, self.password) || 
      Employee.find_by_first_name_and_password(first_name, "")
   end

   def self.login(first_name, password)
      hashed_password = hash_password(password || "")
 STDERR.puts hashed_password
      find(:first, :conditions => ["first_name = ? and password = ?", first_name, hashed_password])
   end

   def update_password(user, password)
      user = Employee.find(session[:user])
      user.password = hash_password(params[:password])
      
   end


end
