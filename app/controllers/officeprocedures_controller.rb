class OfficeproceduresController < ApplicationController
  def index
    list
    render_action 'list'
  end

  def list
    @officeprocedures = Officeprocedure.find_all
  end

  def show
    @officeprocedure = Officeprocedure.find(@params['id'])
  end

  def new
    @officeprocedure = Officeprocedure.new
  end

  def create
    @officeprocedure = Officeprocedure.new(@params['officeprocedure'])
    if @officeprocedure.save
      flash['notice'] = 'Officeprocedure was successfully created.'
      redirect_to :action => 'list'
    else
      render_action 'new'
    end
  end

  def edit
    @officeprocedure = Officeprocedure.find(@params['id'])
  end

  def update
    @officeprocedure = Officeprocedure.find(@params['officeprocedure']['id'])
    if @officeprocedure.update_attributes(@params['officeprocedure'])
      flash['notice'] = 'Officeprocedure was successfully updated.'
      redirect_to :action => 'show', :id => @officeprocedure.id
    else
      render_action 'edit'
    end
  end

  def destroy
    Officeprocedure.find(@params['id']).destroy
    redirect_to :action => 'list'
  end
end
