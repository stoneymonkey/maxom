class BofwDepositController < ApplicationController
	#scaffold :bofw_deposit
	
	def index
      list
      render_action 'list'
    end
  
    def show
      @transactions = BofwDeposit.find(@params['id'])
    end
	
	def list
	  @transactions = BofwDeposit.find_by_sql("select * from bofw_deposits where month(Date_rec)='#{Time.now.month}' and year(Date_rec)='#{Time.now.year}'")
	end
	
end
