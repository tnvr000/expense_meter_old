# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = {
  'Income' => [
    'Paycheck',
    'Pridictable Bonus',
    'Rental Property'
  ],
  'Housing' => [
    'Mortgage',
    'Rent',
    'Renter Insurance',
    'Property Tax',
    'Household Repairs',
    'HOA Fees',
    'Large Appliances'
  ],
  'Transportation' => [
    'Maintenance',
    'Oil Change',
    'Parking Fees',
    'Repairs',
    'Registration',
    'DMV Fees',
    'Toll Payment',
    'Public Transportation Fees',
    'Fuel'
  ],
  'Food' => [
    'Groceries',
    'Resraurants',
    'Snacks'
  ],
  'Utilities' => [
    'Electricity',
    'Water',
    'Garbage',
    'LPG',
    'Phones',
    'Cable',
    'Internet'
  ],
  'Healthcare' => [
    'Prinary Care',
    'Specialty Care',
    'Urgent Care',
    'Medication',
    'Medical Devices'
  ],
  'Insurance' => [
    'Auto Insurance',
    'Life Insurance',
    'Health Insurance',
    'Disabilities Insurance',
    'Rental Insurance',
    'Home Warrenty'
  ],
  'Household Supplies' => [
    'Toiletries',
    'Laundry Detergent',
    'Dishwasher Detergent',
    'Cleaning Supplies',
    'Tool',
    'Napkin',
    'Paper Towel',
    'Toilet Paper',
    'Small Appliances',
    'Emergency Kits',
  ],
  'Personal' => [
    'Gym Membership',
    'Cloth',
    'Shoe',
    'Haircut',
    'Cosmetics',
    'Babysitter'
  ],
  'Dept' => [
    'Personal Loan',
    'Student Loan',
    'Credit Card',
    'Car Payment'
  ],
  'Retirement' => [
    'Financial Planning',
    'Investing'
  ],
  'Education' => [
    'Book',
    'College Fees',
    'School Fees',
    'School Supplies',
    'Private Tuition',
    'Summer Camp',
    'Daycare'
  ],
  'Saving' => [
    'Emergency Fund',
    'Big Purchase',
    'Other Saving'
  ],
  'Gift' => [
    'Birthday',
    'Anniversary',
    'Wedding',
    'Festival',
    'Special Occasion',
    'Zak\'at'
  ],
  'Entertainment' => [
    'Games',
    'Movies',
    'Concert',
    'Vacation',
    'Subscription'
  ],
  'Pets' => [
    'Grooming',
    'Pet Food',
    'Pet Accessories',
    'Veterinary Visits'
  ],
  'Miscellaneous' => [
    'Bank Fees',
    'Credit Card Fees',
    'Professional Dues',
    'State and Federal Taxes',
    'Other'
  ]
}

categories.each_key do |primary_key|
  primary_category = PrimaryCategory.create(name: primary_key)
  categories[primary_key].each do |key|
    primary_category.categories.create(name: key)
  end
  puts "primary category #{primary_key} and it's categories created"
end

customer1 = Customer.create(email: 'tnvr000@gmail.com', password: 'password')
customer2 = Customer.create(email: 'tnvr.ah.kh@gmail.com', password: 'password')
customer3 = Customer.create(email: 'tanveerk@mindfiresolutions.com', password: 'password')
puts 'customers created'

customer1.create_profile(name: 'Tanveer Khan', contact: '8594976909')
customer2.create_profile(name: 'Tanveer Ahmad Khan', contact: '9142711416')
customer3.create_profile(name: 'Tanveer', contact: '9458429452')
puts 'customer profile updated'

account1 = customer1.create_account(balance: 13_000)
account2 = customer2.create_account(balance: 3_100)
account3 = customer3.create_account(balance: 2_700)
puts 'accounts created'

account1.create_cash(balance: 500)
account2.create_cash(balance: 600)
account3.create_cash(balance: 700)
puts 'cashes created'

account1.banks.create(name: 'State Bank of India', balance: 2500)
account1.banks.create(name: 'Axis Bank', balance: 10_000)
account2.banks.create(name: 'State Bank of India', balance: 2_500)
account3.banks.create(name: 'State Bank of India', balance: 2_000)
puts 'banks created'

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

tag1 = Tag.create(name: 'vegitable', customer_id: customer1.id)
tag2 = Tag.create(name: 'trip', customer_id: customer1.id)
tag3 = Tag.create(name: 'accomadation', customer_id: customer1.id)
tag4 = Tag.create(name: 'ration', customer_id: customer1.id)

groceries_category = Category.find_by(name: 'Groceries')
transportation_category = Category.find_by(name: 'Public Transportation Fees')
rent_category = Category.find_by(name: 'Rent')

customer1expenses = customer1.expenses.create(
  [
    {
      date: Date.new(2019, 10, 2),
      title: 'green chilli',
      amount: 15.0,
      description: 'quater KG',
      category_id: groceries_category.id
    }, {
      date: Date.new(2019, 7, 13),
      group_id: group1.id,
      title: 'Transportation',
      amount: 5000.0,
      description: 'from Bhubaneswar to Belghar and back',
      category_id: transportation_category.id
    }
  ]
)

customer2expenses = customer2.expenses.create(
  [
    {
      date: Date.new(2019, 9, 23),
      title: 'Coriander',
      amount: 5.0,
      description: '1 Bundle',
      category_id: groceries_category.id
    }, {
      date: Date.new(2019, 11, 10),
      group_id: group1.id,
      title: 'Resort',
      amount: 5000.0,
      description: 'AC Tent',
      category_id: rent_category.id
    }, {
      date: Date.new(2019, 11, 10),
      group_id: group2.id,
      title: 'Transportation',
      amount: 5000.0,
      description: 'from Bhubaneswar to Daringbadi and back',
      category_id: transportation_category.id
    }
  ]
)

customer3expenses = customer3.expenses.create(
  [
    {
      date: Date.new(2019, 9, 4),
      title: 'Lemons',
      amount: 20.0,
      description: '4 Piece',
      category_id: groceries_category.id
    }, {
      date: Date.new(2019, 7, 13),
      group_id: group2.id,
      title: 'Resort',
      amount: 5000.0,
      description: 'AC Tent',
      category_id: rent_category.id
    }, {
      date: Date.new(2019, 9, 8),
      group_id: group1.id,
      title: 'Ration',
      amount: 1000.0,
      description: 'Ration to cook food',
      category_id: groceries_category.id
    }
  ]
)
puts 'expenses created'

Tagging.create(expense_id: customer1expenses[0].id, tag_id: tag1.id)
Tagging.create(expense_id: customer1expenses[1].id, tag_id: tag2.id)
Tagging.create(expense_id: customer2expenses[0].id, tag_id: tag1.id)
Tagging.create(expense_id: customer2expenses[1].id, tag_id: tag3.id)
Tagging.create(expense_id: customer3expenses[2].id, tag_id: tag2.id)
Tagging.create(expense_id: customer3expenses[0].id, tag_id: tag1.id)
Tagging.create(expense_id: customer3expenses[1].id, tag_id: tag3.id)
Tagging.create(expense_id: customer3expenses[2].id, tag_id: tag4.id)

puts 'expenses tagged'
