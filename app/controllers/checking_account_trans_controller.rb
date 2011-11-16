class CheckingAccountTransController < ApplicationController
  
  def add_bofw
    @types = Account.find_by_sql("select Account Account from account_types order by account").map {|type| [type.Account, type.Account]}
	#@transaction = Bofw.new
	#render :page => :add_bofw
	
  end
  
  def add_cvcb
	@types = Account.find_by_sql("select Account Account from account_types order by account").map {|type| [type.Account, type.Account]}
	#@transaction = Cvcb.new
  end
  
  def new_bofw
	@trans = Bofw.new(params[:bofw])
  end

  def new_cvcb
	@trans = Cvcb.new(params[:cvcb])
  end

   def uncleared
      # I need to create a generic object but am not sure what to call
      # it.  cat...
      if @params.length < 1
        flash['notice'] = 'No Account Selected'
        redirect_to :controller => 'maxom'
      end
      if @params[:acc] == "bofw"
         @items = Bofw.getOutstandingWithdrawls
      elsif @params[:acc] == "cvcb"
         @items = Cvcb.getOutstandingWithdrawls
      else
        flash['notice'] = 'No Account Selected'
        redirect_to :controller => 'maxom'
      end
   end

   def uncleared_totals
      @outstanding_balance = Bofw.getOutstandingWithdrawls_Total
      @current_balance = Bofw.getCurrentBalance
  end
end
