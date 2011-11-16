require 'payable'
require 'employee'
require 'workorder'

class Purchaseorder < ActiveRecord::Base
   has_many :po_items
   #contains_one  :payable
   belongs_to :payable
   belongs_to :employee
   belongs_to :workorder
   #has_one :payable
   #has_one :employee
   #has_one :workorder

end
