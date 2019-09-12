require_relative '../config/environment'






cli = Interface.new
customer_object = cli.welcome
 puts customer_object
 while customer_object == nil
    customer_object = cli.welcome
 end

#  cli.customer = customer_object
 
 cli.main_menu(customer_object)

 puts "hello world"



 puts customer_object.name