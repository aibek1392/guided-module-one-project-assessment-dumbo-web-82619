class Contract < ActiveRecord::Base
    belongs_to :moving_company
    belongs_to :customer
end
   