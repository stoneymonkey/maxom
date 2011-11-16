require 'payable'
require 'employee'

class PurchaseorderController < ApplicationController
   scaffold :purchaseorder
   #scaffold :po_item

def display
  @po = Purchaseorder.find(@params["id"])
end

def list
  @po = Purchaseorder.find_all
  @vendor = Payable
  @employee = Employee
  @client = Client
  @workorder = Workorder
end

#def edit
  #@po = Purchaseorder.find(@params["id"])
  #@mode = "edit" 
#end

def new
  @po = Purchaseorder.new()
  @vendors = Payable.find_by_sql("SELECT * FROM payables WHERE category='vendor' ORDER BY Account_Name")
  @employees = Employee.find_by_sql("SELECT * FROM employees WHERE id < 5") 
  #@mode = "new" 
  #render_action "edit" 
end

end
