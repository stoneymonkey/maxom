class Cvcb < ActiveRecord::Base
   def self.table_name()
      "cvcb"
   end

   def self.primary_key()
      "transaction_id"
   end
   def self.getOutstandingWithdrawls_Total
      item = Cvcb.find_by_sql("SELECT SUM(amount) FROM cvcb WHERE clear_date=0000-00-00")
      item.each do |item|
         return item.attributes["SUM(amount)"]
      end
   end

   def self.getOutstandingWithdrawls
      @items = Cvcb.find_by_sql("select * from cvcb where clear_date = 0000-00-00")
   end

   def self.getCurrentBalance
      item = Cvcb.find_by_sql("select SUM(amount) from cvcb")
      item.each do |item|
         return item.attributes["SUM(amount)"]
      end
   end

   def self.getUnreconciled(year, month)
            @items = Cvcb.find(:all,
                        :conditions => "year(transaction_date) = #{year} and month(transaction_date) = #{month}",
                        :order => "transaction_date desc"
                        )
   end

   def self.getReconciled(year, month)
      @items = Cvcb.find(:all,
                         :conditions => "year(transaction_date) = #{year} and month(transaction_date) = #{month} and reconciled = '1'",
                         :order => "transaction_date desc"
                         )
   end

   def self.getUnreconciledChecks(year, month, sort)
        @checks = find(:all,
			 :conditions => "year(clear_date) = #{year} and month(clear_date) = #{month} and trans_type = 1 and reconciled != 1",
			 :order => "#{sort}"
		)

   end

   def self.getUnreconciledDebits(year,month, sort)
      @debits = find(:all,
		 :conditions => "year(clear_date) = #{year} and month(clear_date) = #{month} and trans_type != 1 and amount < 0 and reconciled != 1",
		 :order => "#{sort}"
		)      
   end

   def self.getUnreconciledDeposits(year,month, sort)
      @items = Cvcb.find(:all,
			 :conditions => "year(clear_date) = #{year} and month(clear_date) = #{month} and amount > 0 and reconciled != 1",
			 :order => "#{sort}"
		)  
   end

   def self.getReconciled(year, month)
      @items = Cvcb.find(:all,
                         :conditions => "year(transaction_date) = #{year} and month(transaction_date) = #{month} and reconciled = '1'",
                         :order => "transaction_date desc"
                         )
   end

  def self.getAccountAsOf(year, month, sort)
     @items = Cvcb.find(:all, :conditions => "year(transaction_date) = #{year} and month(transaction_date) = #{month}", :order => "#{sort}")
  end

  def self.getTotalCheckAmountsPerMonth(year, month)
	item = Cvcb.find_by_sql("SELECT ABS(SUM(amount)) FROM cvcb WHERE MONTH(clear_date)=#{month} AND YEAR(clear_date)=#{year} and trans_type = 1 and amount < 0");
        item.each do |item|
         return item.attributes["ABS(SUM(amount))"]
      end
  end

  def self.getTotalDebitAmountsPerMonth(year, month)
        item = Cvcb.find_by_sql("SELECT ABS(SUM(amount)) FROM cvcb WHERE MONTH(clear_date)=#{month} AND YEAR(clear_date)=#{year} and amount < 0 and trans_type != 1")
        item.each do |item|
         return item.attributes["ABS(SUM(amount))"]
      end
  end
  def self.getTotalDepositAmountsPerMonth(year, month)
      item = Cvcb.find_by_sql("SELECT SUM(amount) FROM cvcb WHERE MONTH(clear_date)=#{month} AND YEAR(clear_date)=#{year} AND amount > 0")
      item.each do |item|
         return item.attributes["SUM(amount)"]
      end
  end
  def  self.getPayrollTotalFor(year, terms, sort)
	@items = Cvcb.find(:all,
				:conditions => "payee like '%#{terms}%' and year(transaction_date)=#{year}",
				:order => "#{sort}"
				)
  end

  def self.getExpensesByCat(year, month, cat)
     item = Cvcb.find_by_sql("select abs(sum(amount)) from cvcb where year(transaction_date) = #{year} and month(transaction_date) = #{month} and account_type='#{cat}'"
	)
      item.each do |item|
         return item.attributes["abs(sum(amount))"]
      end
  end

  def self.getAccountTypeByMonth(year, month, at, sort)
    at = Account.getAccountName(at)
    item = Cvcb.find(:all,
			:conditions => "year(transaction_date)=#{year} and month(transaction_date)=#{month} and account_type='#{at}'",
			:order => "#{sort}" )
  end

end
