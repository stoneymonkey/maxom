class OfficeprocedureController < ApplicationController
   scaffold :officeprocedure

def newer
  @bofw_balance = Bofw.getCurrentBalance
  @bofw_outstanding_balance = Bofw.getOutstandingWithdrawls_Total
  @cvcb_balance = Cvcb.getCurrentBalance
  @cvcb_outstanding_balance = Cvcb.getOutstandingWithdrawls_Total
end

def show_add_entries_params
  render_text @params.inspect
  #add_entry
end

def add_entry
  item = officeprocedure.new  # Create a new instance of Todo, so create a new item
  item.attributes = @params["new_entry"]  # The fields of item should be set to what's in the "new_item" hash

  if item.save  # Try to save our item into the database
    redirect_to(:action => "list")  # Return to the list page if it suceeds  else
    render_text "Couldn't add new entry"  # Print an error message otherwise
  end
end

end
