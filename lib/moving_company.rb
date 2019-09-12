class MovingCompany < ActiveRecord::Base
    has_many :contracts
    has_many :customers, through: :contracts
   
    def self.tty_prompt
        TTY::Prompt.new
    end

    def self.list_company_names_by_state(state)
        c_list = MovingCompany.all.select do |mc|
            mc.location == state
        end
       c_list.map do |mc|
        mc.name
       end
    end

 
end
