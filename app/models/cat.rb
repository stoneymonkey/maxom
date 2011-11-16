class Cat < ActiveRecord::Base
   
   attr_reader: table_name
   attr_reader: balance
   
   def self.set_name(name)
      name = self.table_name
   end
  
   def self.name
      return self.table_name
   end

   def self.primary_key()
      "transaction_id"
   end

   def self.getOutstandingWithdrawls_Total
      item = `Bofw`.find_by_sql("SELECT SUM(amount) FROM bofw WHERE clear_date=0000-00-00")
      item.each do |item|
         return item.attributes["SUM(amount)"]
      end
   end

   def self.getOutstandingWithdrawls
      @items = Bofw.find_by_sql("select * from bofw where clear_date = 0000-00-00")
   end

   def self.getCurrentBalance
      item = Bofw.find_by_sql("select SUM(amount) from bofw")
      item.each do |item|
         return item.attributes["SUM(amount)"]
      end
   end
end
