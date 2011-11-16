class ExpensesController < ApplicationController

   def index
      @categories = Account.find(:all)
      @exp_totals = Array2.new
      $number_of_cats = @categories.length 
      if @params[:acc] == "bofw"
         @items = self.getTotalsByCatByAcc(@params[:acc])
      elsif @params[:acc] == "cvcb"
         @items = self.getTotalsByCatByAcc(@params[:acc])
      elsif @params[:acc] == "all"
         self.getTotalsByCat
      else
        flash['notice'] = 'No Account Selected'
        #redirect_to :controller => 'maxom'
        render_text "No Account Selected"
      end

   end

   def show
	
   end

   def getTotalsByCatByAcc(acc)
      for i in 0..@categories.length-1
        for x in 1..12	 
          if acc == "bofw"
           @acc = Bofw.getExpensesByCat(params[:year], x, "#{@categories[i].Account}")
          else 
           @acc = Cvcb.getExpensesByCat(params[:year], x, "#{@categories[i].Account}")
          end
           @exp_totals[i,x] = @acc
           #flash['notice'] = "test"
        end
      end  
      
   end

   def getTotalsByCat
      for i in 0..@categories.length-1
        for x in 1..12
           bofw = Bofw.getExpensesByCat(params[:year], x, "#{@categories[i].Account}")
           cvcb = Cvcb.getExpensesByCat(params[:year], x, "#{@categories[i].Account}")
           @exp_totals[i,x] = bofw.to_f + cvcb.to_f 
           #flash['notice'] = "test"
        end
      end  
   end

end

  class Array2

   def initialize
     @store = [[]]
   end

   def [](a,b)
    if @store[a]==nil ||
      @store[a][b]==nil
     return nil
    else
     return @store[a][b]
    end
   end

   def []=(a,b,x)
    @store[a] = [[]] if @store[a]==nil
    @store[a][b] = [] if @store[a][b]==nil
    @store[a][b] = x
   end

   def length
      return @store.length
   end

  end
