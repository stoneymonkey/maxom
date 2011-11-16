class Client < ActiveRecord::Base
 has_many :workorders

 def self.primary_key()  "Client_ID"  end

end
