class ReconcileController < ApplicationController
 
   def show
      if @params[:sort].nil?
          @params[:sort] = "clear_date"
      end
      if @params.length < 3
        flash['notice'] = 'No Account Selected'
        redirect_to :controller => 'maxom'
      end
      @types = Account.find_by_sql("select Account Account from account_types order by account").map {|type| [type.Account, type.Account]}
      if @params[:acc] == "bofw"							# if account is 'bofw'
	 @col_names = Bofw.column_names()
         if @params[:view] == "deposits" 						# if view is 'deposits'
             @items = Bofw.getUnreconciledDeposits(params[:year],params[:month],params[:sort])
	     @total = Bofw.getTotalDepositAmountsPerMonth(params[:year],params[:month])
         elsif @params[:view] == "debits"						# if view is 'debits'
             @items = Bofw.getUnreconciledDebits(params[:year],params[:month],params[:sort])
	     @total = Bofw.getTotalDebitAmountsPerMonth(params[:year],params[:month])
         elsif @params[:view] == "checks"							# if view is 'checks' 	
             @items = Bofw.getUnreconciledChecks(params[:year],params[:month],params[:sort])
	     @total = Bofw.getTotalCheckAmountsPerMonth(params[:year],params[:month])
         else
            #redirect_to :controller => 'maxom'
         end
      elsif @params[:acc] == "cvcb"
	 @col_names = Cvcb.column_names()
         if @params[:view] == "deposits"
             @items = Cvcb.getUnreconciledDeposits(params[:year],params[:month],params[:sort])
	     @total = Cvcb.getTotalDepositAmountsPerMonth(params[:year],params[:month])
   #if view us debits
         elsif @params[:view] == "debits"
             @items = Cvcb.getUnreconciledDebits(params[:year],params[:month],params[:sort])

	     @debits = Cvcb.getTotalDebitAmountsPerMonth(params[:year],params[:month])
	     @checks = Cvcb.getTotalCheckAmountsPerMonth(params[:year],params[:month])
	     @total = @checks.to_i + @debits.to_i
    #if view is checks
         elsif @params[:view] =="checks"
             @items = Cvcb.getUnreconciledChecks(params[:year],params[:month],params[:sort])
	     @debits = Cvcb.getTotalDebitAmountsPerMonth(params[:year],params[:month])
	     @checks = Cvcb.getTotalCheckAmountsPerMonth(params[:year],params[:month])
	     @total = @checks.to_i + @debits.to_i
         else
            redirect_to :controller => 'maxom'
         end
      else
        flash['notice'] = 'No Account Selected'
        redirect_to :controller => 'maxom'
      end
   end

   def reconciled
      if @params.length < 3
        flash['notice'] = 'No Account Selected'
        redirect_to :controller => 'maxom'
      end
      if @params[:acc] == "bofw"
         @items = Bofw.getReconciled(params[:year],params[:month])
      elsif @params[:acc] == "cvcb"
         @items = Cvcb.getReconciled(params[:year],params[:month])
      else
        flash['notice'] = 'No Account Selected'
        redirect_to :controller => 'maxom'
      end
   end

   def reconcile
      to_be_reconciled = @params[:to_be_reconciled]
         if to_be_reconciled
            to_be_reconciled.each do |id, reconcile_it|
	      if reconcile_it == "yes"
                 if @params[:acc] == "bofw"
                    item = Bofw.find(id)
		    item.reconciled = 1
                    item.save
                 end
                 if @params[:acc] == "cvcb"
                    item = Cvcb.find(id)
		    item.reconciled = 1
		    item.save
                 end
            end
         end
      end
     redirect_to( url_for(:controller => "reconcile", :action => "show", :acc => "#{params[:acc]}", :year => "#{params[:year]}", :month => "#{params[:month]}", :view => "#{params[:view]}", :sort => "#{params[:sort]}") )
   end

end
