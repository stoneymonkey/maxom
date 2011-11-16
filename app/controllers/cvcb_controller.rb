class CvcbController < ApplicationController

  def index
    list
    render_action 'list'
  end

  def list
    if params != nil 
        @transactions = Cvcb.find_by_sql("select * from cvcb where month(transaction_date)='#{Time.now.month}' and year(transaction_date)='#{Time.now.year}'")
	else
	    @transactions = Cvcb.find_by_sql("select * from cvcb where month(transaction_date)='#{params[:month]}' and year(transaction_date)='#{params[:year]}'")
	end
  end

  def show
    @transactions = Cvcb.find(@params['id'])
  end

  def new
    @types = Account.find_by_sql("select Account Account from account_types order by account").map {|type| [type.Account, type.Account]}
    @transaction = Cvcb.new
  end

  def create
    @transaction = Cvcb.new(@params[:cvcb])
    if @transaction.save
      flash['notice'] = 'Banking account trans. was successfully created.'
      redirect_to :action => 'list'
    else
      render_action 'new'
    end
  end

  def edit
    @types = Account.find_by_sql("select Account Account from account_types order by account").map {|type| [type.Account, type.Account]}
    @transaction = Cvcb.find(@params['id'])
  end

  def update
    @types = Account.find_by_sql("select Account Account from account_types order by account").map {|type| [type.Account, type.Account]}
    @transaction = Cvcb.find(@params['cvcb']['id'])
    if @transaction.update_attributes(@params['cvcb'])
      flash['notice'] = 'Banking account trans. was successfully updated.'
      redirect_to :action => 'show', :id => @cvcb.id
    else
      render_action 'edit'
    end
  end

  def destroy
    Cvcb.find(@params['id']).destroy
    redirect_to :action => 'list'
  end

end
