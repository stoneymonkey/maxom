class Account < ActiveRecord::Base
   def self.primary_key()
      "Account_Type"
   end
   def self.table_name()
      "account_types"
   end

   def self.getTotalCats()
	item = Account.find_by_sql("select count(*) from account_types") 
   end

   def self.getAccountName(id)
        
	#name = Account.find_by_sql("select Account from account_types where Account_Type=#{id}")
        name = Account.find(id).Account
        #return name
   end
end
