Contract.destroy_all
Customer.destroy_all
MovingCompany.destroy_all

mark = Customer.create(name: "Mark", size: "One Bedroom", location: "Florida")
alex = Customer.create(name: "Alex", size: "Studio", location: "Connecticut")
john = Customer.create(name: "John", size: "Two Bedroom", location: "New Jersey")
kate = Customer.create(name: "Kate", size: "Storage", location: "New York")

m1 = MovingCompany.create(name: "White Gloves", location: "New York", quantity: 5)
m2 = MovingCompany.create(name: "Dumbo Movers", location: "Connecticut", quantity: 3)
m3 = MovingCompany.create(name: "May Flower", location: "Florida", quantity: 2)
m4 = MovingCompany.create(name: "Star Movers", location: "New Jersey", quantity: 4)
m5 = MovingCompany.create(name: "Phoenix", location: "Florida", quantity: 2)
m6 = MovingCompany.create(name: "Piano Movers", location: "New York", quantity: 5)
m7 = MovingCompany.create(name: "Big Guy", location: "New Jersey", quantity: 4)
m8 = MovingCompany.create(name: "Fast Movers", location: "Connecticut", quantity: 3)
m9 = MovingCompany.create(name: "Blade", location: "New York", quantity: 5)
m10 = MovingCompany.create(name: "Sea Gate", location: "Florida", quantity: 2)


c1 = Contract.create(time: "Saturday Afternoon 2pm", customer_id: mark.id, moving_company_id: m3.id, price: 300)
c2 = Contract.create(time: "Sunday Morning 9am", customer_id: alex.id, moving_company_id: m2.id, price: 500 )
c3 = Contract.create(time: "Monday Morning 9am", customer_id: john.id, moving_company_id: m4.id, price: 1000)
c4 = Contract.create(time: "Saturday Morning 9am", customer_id: kate.id, moving_company_id: m1.id, price:  1500)



puts "It has been seeded."