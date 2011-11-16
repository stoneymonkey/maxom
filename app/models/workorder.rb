class Workorder < ActiveRecord::Base
   has_many :labors
   belongs_to :job
   has_one :invoice
   belongs_to :client
end
