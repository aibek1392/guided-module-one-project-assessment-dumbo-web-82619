class Customer < ActiveRecord::Base
    has_many :contracts
    has_many :moving_companies, through: :contracts 
    attr_accessor :the_company_instance

    def self.tty_prompt
        TTY::Prompt.new
    end

    def tty_prompt
        TTY::Prompt.new
    end

    def self.handle_new_user
        name = self.tty_prompt.ask("What is your name?")
        Customer.create(name: name)
        sleep 1
    end
    
    def self.handle_returning_user
        name = self.tty_prompt.ask("Welcome back! What is your name?")
        if Customer.find_by(name: name)
            Customer.find_by(name: name)
        else 
            Interface.run_program
        end
        # binding.pry
    end
        
    def self.handle_name_companies
        name = self.tty_prompt.ask("Here is the list of moving companies")
        moving_companies = MovingCompany.all.map do |mc|
            puts mc.name
        end
    
        puts moving_companies
    end
    
    def customer_info
        self.reload
        puts "Name: #{self.name}"
        change = TTY::Prompt.new.select("What would you like to change") do |menu|

        menu.choice "Change your name", -> {self.update_customer_info}
        menu.choice "Delete your account", -> {self.delete_account}
        menu.choice "View accounts", -> {self.view_all_created_accounts}
        end
    end
     
    def location_states
        loc_list = Customer.all.map do |ls|
            ls.location
        end
        loc_list
    end

    def quantity_of_mover
        movers_list = MovingCompany.all.map do |mc|
            mc.quantity
        end
        movers_list
    end
    
    # def get_available_dates
    #     av_dates = Contract.all.map do |mc|
    #         mc.time
    #     end
    #     av_dates
    # end
    def self.make_contract
        movers = list
        Contract.new(customer_id: self.id, moving_company_id: self.id )
        # binding.pry
        # 0
    end
        
    def update_customer_info
        new_name = self.tty_prompt.ask("What is your new name?")
        self.update(name: new_name)
        name = new_name
        puts "\n#{new_name} has been updated!"
    end
  
    def delete_account
        # binding.pry
        self.destroy
        # self.customer_info
    end

    def quantity_chosen_by_customer
        # price_by_quantity = self.tty_prompt.select("Select quantity of movers", self.customer.quantity_of_movers)
        choice= self.tty_prompt.select("This is the estimated price for your job depending on how many movers you need") do |menu|
            menu.choice '2 = 300'
            menu.choice '3 = 500'
            menu.choice '4 = 1000'
            menu.choice '5 = 1500'
        end
        case choice 
        when '2 = 300'
            300
        when '3 = 500'
            500
        
        when   '4 = 1000' 
            1000
        when  '5 = 1500'
            1500
        end
    end
        

    def state_to_live
    state_moving_to = self.tty_prompt.select("In which state do you live?", self.location_states)
        # binding.pry
        choice = self.tty_prompt.select("Choose the company you want?", MovingCompany.list_company_names_by_state(state_moving_to))
        # "May Flower"
        MovingCompany.find_by(name: choice)
        # binding.pry
       
    end
    
    def handle_contracts
        
        system "clear"
        names_array = Contract.all.map do |sk|
            sk.time
        end
        names_array = names_array.uniq
        choice = self.tty_prompt.select("Here is the available dates", names_array) 
        case choice
            when "Saturday Afternoon 2pm"
                puts "added to the Contracts"
                moving_company_instance = self.state_to_live
                quantity_string = self.quantity_chosen_by_customer
                Contract.create(time: "Saturday Afternoon 2pm",  customer_id: self.id, moving_company_id: moving_company_instance.id, price: quantity_string)
                
            when "Exit"
                
            when "Sunday Morning 9am"
                moving_company_instance = self.state_to_live
                quantity_string = self.quantity_chosen_by_customer
                Contract.create(time: "Sunday Morning 9am",  customer_id: self.id, moving_company_id: moving_company_instance.id, price: quantity_string)
            when "Exit" 
            
            when "Monday Morning 9am"
                moving_company_instance = self.state_to_live
                quantity_string = self.quantity_chosen_by_customer
                Contract.create(time: "Monday Morning 9am",  customer_id: self.id, moving_company_id: moving_company_instance.id, price: quantity_string)
            when "Exit"
            
            when "Sunday morning 9am"
                moving_company_instance = self.state_to_live
                quantity_string = self.quantity_chosen_by_customer
                Contract.create(time: "Sunday morning 9am",  customer_id: self.id, moving_company_id: moving_company_instance.id, price: quantity_string)
            when "Exit"
            when "Sunday Morning 9am"
                moving_company_instance = self.state_to_live
                quantity_string = self.quantity_chosen_by_customer
                Contract.create(time: "Sunday Morning 9am",  customer_id: self.id, moving_company_id: moving_company_instance.id, price: quantity_string)
            when "Exit"

        end
    end


    def view_all_created_accounts
        # self.reload
        accounts_data = Customer.all.map do |customer| 
            "#{customer.name}"

        end     
        self.tty_prompt.select("Contracts", accounts_data)

    end 
       

    def view_all_created_contracts
        self.reload
        contracts_data = self.contracts.map do |contract| 
            "On #{contract.time} with #{MovingCompany.all.find_by(id: contract.moving_company_id).name} for #{contract.price}"

        end     
        self.tty_prompt.select("Contracts", contracts_data)

    end 
      
       
    def go_update_contract

        array_of_contracts = self.contracts.all.map do |contract|
            "#{contract.id} #{contract.time}"
        end
            available_dates = Contract.all.map do |contract|
                contract.time
                # binding.pry
            end
            contract_id = self.tty_prompt.select("Which contract do you want to update?", array_of_contracts)
                contract_chosen = self.contracts.find_by(id: contract_id)
               date_choice = self.tty_prompt.select("Here is available dates",available_dates.uniq)
                contract_chosen.update(time: date_choice)
                # binding.pry
    end  
    
    def delete_contracts
        array_of_contracts = self.contracts.map do |contract|
            contract.id
        end

        contracts_data = self.contracts.map do |contract| 
                "#{contract.id}, On #{contract.time} with #{MovingCompany.all.find_by(id: contract.moving_company_id).name} for #{contract.price}"
        end
           selection = self.tty_prompt.select("Select to delete", contracts_data)
           stringid = selection.split(",").first
        #    binding.pry
           Contract.all.find_by(id: stringid).destroy

           

     end

end
