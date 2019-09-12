class Interface 
    attr_reader :prompt, :path
    attr_accessor :customer, :moving_company
    
    def initialize()
        @prompt = TTY::Prompt.new
        #user does exist
    end
    
    def welcome 
        system "clear"
        art= puts <<-'EOF'
                       _____________________________________________________
                      |                                                     |
             _______  |                                                     |
            / _____ | |                       AIBEK MOVERS                 |
           / /(__) || |                                                     |
  ________/ / |OO| || |                                                     |
 |         |-------|| |                                                     |
(|         |     -.|| |_______________________                              |
 |  ____   \       ||_________||____________  |             ____      ____  |
/| / __ \   |______||     / __ \   / __ \   | |            / __ \    / __ \ |\
\|| /  \ |_______________| /  \ |_| /  \ |__| |___________| /  \ |__| /  \|_|/
   | () |                 | () |   | () |                  | () |    | () |
    \__/                   \__/     \__/                    \__/      \__/
        EOF
        art
    
        
        puts "Welcome to Home Advisor!"
        choice = self.prompt.select("Are you a new user or returning user?") do |menu|
            menu.choice "New User"
            menu.choice "Returning User"
        end
        case choice
        when "New User"
            @path = "New User"
            Customer.handle_new_user
            self.welcome
        when "Returning User"
            @path = "Returning User"
            Customer.handle_returning_user
        end 
    end

    def main_menu(customer_object)
        system "clear"
        choice = self.prompt.select("Welcome! What do you want to do?") do |menu|
            menu.choice "Account information", -> {customer_object.customer_info}
            # menu.choice "How many movers do you want?", -> {customer_object.quantity_chosen_by_customer}
            menu.choice "View Contracts", -> {customer_object.view_all_created_contracts}
            
            menu.choice "Make Contract", -> {customer_object.handle_contracts} 
            menu.choice "Update contract", -> {customer_object.go_update_contract}
            menu.choice "Delete contracts", -> {customer_object.delete_contracts}
            menu.choice "exit", -> {self.welcome}
        end
        self.main_menu(customer_object) 
        case choice 
        when "What date do you want to move?"
            choice= self.prompt.select("this is available dates we have",customer_object.available_dates) 
        
            self.main_menu(customer_object)   

 
                when "Exit"
                        welcome
        
             
                
            end

        
        end
                
                
                
    def self.run_program
        cli = self.new 
        cust =  cli.welcome 
        cli.main_menu(cust)
    end
           

end