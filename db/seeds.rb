# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
customer = Customer.create(email: 'tnvr.ah.kh@gmail.com', password: 'password')

customer.expenses.create(
  [
    {
      'title'=>'green chilli',
      'amount'=>15.0,
      'description'=>'quater KG'
    }, {
      'title'=>'Coriander',
      'amount'=>5.0,
      'description'=>'1 peace'
    }
  ]
)