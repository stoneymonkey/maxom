class TestsController < ApplicationController
  def index
    list
    render_action 'list'
  end

  def list
    @tests = Test.find_all
  end

  def show
    @test = Test.find(@params['id'])
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(@params['test'])
    if @test.save
      flash['notice'] = 'Test was successfully created.'
      redirect_to :action => 'list'
    else
      render_action 'new'
    end
  end

  def edit
    @test = Test.find(@params['id'])
  end

  def update
    @test = Test.find(@params['test']['id'])
    if @test.update_attributes(@params['test'])
      flash['notice'] = 'Test was successfully updated.'
      redirect_to :action => 'show', :id => @test.id
    else
      render_action 'edit'
    end
  end

  def destroy
    Test.find(@params['id']).destroy
    redirect_to :action => 'list'
  end
end
