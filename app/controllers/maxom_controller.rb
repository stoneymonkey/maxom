class MaxomController < ApplicationController
   #scaffold :bofw
   #	scaffold :cvcb
   model :bofw
   model :cvcb
   model :account_type
model :client
   #model :bank
   
   before_filter :authorize

   # Show uncleared items in specific bank account.
   def Uncleared
      # I need to create a generic object but am not sure what to call
      # it.  cat...
      if @params[:acc] == "bofw"
         @items = Bofw.getOutstandingWithdrawls
      elsif @params[:acc] == "cvcb"
         @items = Cvcb.getOutstandingWithdrawls
      else
        flash['notice'] = 'No Account Selected'
        #redirect_to :controller => 'maxom'
        render_text "No Account Selected"
      end
   end

   def Uncleared_Totals
      @outstanding_balance = Bofw.getOutstandingWithdrawls_Total
      @current_balance = Bofw.getCurrentBalance
  end
  def current_balance
      if @params[:acc] == "bofw"
        @current_balance = Bofw.getCurrentBalance
        render_text(@current_balance)
      elsif @params[:acc] == "cvcb"
        @current_balance = Cvcb.getCurrentBalance 
        render_text(@current_balance)
      else
        flash['notice'] = 'No Account Selected'
        #redirect_to :controller => 'maxom'
        render_text "No Account Selected"
      end
  
  end
  def show	
 # Make sure the the sort param is not empty else fill it with transaction_id.
      if params[:sort].nil?
         @params[:sort] = 'transaction_id'
      end
 # Populate an array with Colum Names from the Bank Statements 
	 @col_names = Bofw.column_names()
 # The month param can grow to reach the value 13. However this does the program little good
 # for the Calendar only goes up to 12 months.
      if @params[:month].to_i >= 13 
   # The thirteenth months becomes Jan
         @params[:month] = 1
         @params[:year] = @params[:year].to_i + 1
   # If the month param is a negative number we change it to 12 eg December.
      elsif @params[:month].to_i <= 0
         @params[:month] = 12
         @params[:year] = @params[:year].to_i - 1
      else
      end
  #
      if @params[:acc] == "bofw"
	if @params[:cat].nil?
           @items = Bofw.getAccountAsOf(params[:year],params[:month],params[:sort])
	else
	    #@params[:cat] = Account.getAccountName(@params[:cat])
	    @items = Bofw.getAccountTypeByMonth(params[:year],params[:month],params[:cat],params[:sort])
        end
      elsif @params[:acc] == "cvcb"
	if @params[:cat].nil?
           @items = Cvcb.getAccountAsOf(params[:year],params[:month],params[:sort])
	else @items = Cvcb.getAccountTypeByMonth(params[:year],params[:month],params[:cat],params[:sort])
        end 
      else
        flash['notice'] = 'No Account Selected'
        #redirect_to :controller => 'maxom'
        render_text "No Account Selected"
      end
  end
  def edit
      #@types = Account.find(:all, :order => "Account").map {|type| [type.Account, type.Account_Type]}
      @types = Account.find_by_sql("select Account Account from account_types order by account").map {|type| [type.Account, type.Account]}
      if @params[:acc] == "bofw"
         @item = Bofw.find(params[:id])
      elsif @params[:acc] == "cvcb"
         @item = Cvcb.find(params[:id])
      else
        flash['notice'] = 'No Account Selected'
        #render_text "Done."
         redirect_to :controller => "maxom", :action => "show"
      end
  end
  # update specified item.
  def update
      if @params[:acc] == "bofw"
         item = Bofw.find(params[:bofw][:id])
         item.update_attributes(params[:bofw])
      elsif @params[:acc] == "cvcb"
         #item = Cvcb.find(params[:id])
         Cvcb.update(params[:cvcb][:id], params[:cvcb])
      else 
         render_text "thisisadud..."
      end
      render_text "Done."
  end
  def new_bank_transaction
       if @params[:acc] == "bofw"
         #item = Bofw.find(params[:id])
         Bofw.update_attributes(params[:id], params[:item])
      elsif @params[:acc] == "cvcb"
         #item = Cvcb.find(params[:id])
         Cvcb.update_attributes(params[:id], params[:item])
      else 
         render_text "thisisadud..."
      end
  end
  def payroll
	@col_names = Bofw.column_names()
	@aaron_bofw = Bofw.getPayrollTotalFor(params[:year], 'aaron', params[:sort])
 	@aaron_cvcb = Cvcb.getPayrollTotalFor(params[:year], 'aaron', params[:sort])
	@ben_bofw = Bofw.getPayrollTotalFor(params[:year], 'ben', params[:sort])
 	@ben_cvcb = Cvcb.getPayrollTotalFor(params[:year], 'ben', params[:sort])
	@gary_bofw = Bofw.getPayrollTotalFor(params[:year], 'gary', params[:sort])
 	@gary_cvcb = Cvcb.getPayrollTotalFor(params[:year], 'gary', params[:sort])
	@larry_bofw = Bofw.getPayrollTotalFor(params[:year], 'larry', params[:sort])
 	@larry_cvcb = Cvcb.getPayrollTotalFor(params[:year], 'larry', params[:sort])
  end
 
  def show_bank
	@account = Bank.table_name("bofw")
        render_text("hey hey")
  end

def list
  @clients = Client.find(:all)

  respond_to do |wants|
    wants.html
    wants.xml { render :xml => @cleints.to_xml }
  end
end

end #end of class
