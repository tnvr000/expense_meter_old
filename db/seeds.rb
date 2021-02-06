# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
customer1 = Customer.create(email: 'tnvr000@gmail.com', password: 'password')
customer2 = Customer.create(email: 'tnvr.ah.kh@gmail.com', password: 'password')
customer3 = Customer.create(email: 'tanveerk@mindfiresolutions.com', password: 'password')
puts 'customers created'

group1 = customer1.my_groups.create(name: 'Belghar Trip')
group2 = customer3.my_groups.create(name: 'Daringbadi Trip')
puts 'Groups created'

group1.members << customer1
group1.members << customer2
group1.members << customer3
group2.members << customer2
group2.members << customer3
puts 'added members to group'

group1.admins << customer1
group1.admins << customer2
group2.admins << customer3
puts 'added admins of groups'

customer1.expenses.create(
  [
    {
      title: 'green chilli',
      amount: 15.0,
      description: 'quater KG'
    }, {
      group_id: group1.id,
      title: 'Transportation',
      amount: 5000.0,
      description: 'from Bhubaneswar to Belghar and back'
    }
  ]
)

customer2.expenses.create(
  [
    {
      title: 'Coriander',
      amount: 5.0,
      description: '1 Bundle'
    }, {
      group_id: group1.id,
      title: 'Resort',
      amount: 5000.0,
      description: 'AC Tent'
    }, {
      group_id: group2.id,
      title: 'Transportation',
      amount: 5000.0,
      description: 'from Bhubaneswar to Daringbadi and back'
    }
  ]
)

customer3.expenses.create(
  [
    {
      title: 'Lemons',
      amount: 20.0,
      description: '4 Piece'
    }, {
      group_id: group2.id,
      title: 'Resort',
      amount: 5000.0,
      description: 'AC Tent'
    }, {
      group_id: group1.id,
      title: 'Ration',
      amount: 1000.0,
      description: 'Ration to cook food'
    }
  ]
)
puts 'expenses created'
