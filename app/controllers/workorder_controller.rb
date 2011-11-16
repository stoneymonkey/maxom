class WorkorderController < ApplicationController
   scaffold :workorder
   model :client

   def index
      @col_names = Workorder.column_names
      @workorders = Workorder.find(:all, :include => "client")
      #render_page 'index'
   end
end
