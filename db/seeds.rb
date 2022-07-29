# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create users, chores, and chore_config records

nate = User.create(name: "Nathanael")
josh = User.create(name: "Joshua")
caleb = User.create(name: "Caleb")
annalise = User.create(name: "Annalise")

devos = Chore.create(name: "Devotions")
mv = Chore.create(name: "Memory Verse")
water = Chore.create(name: "Drink Water Bottle")
teeth = Chore.create(name: "Brush Teeth After Lunch")
piano = Chore.create(name: "Piano Practice")
lr = Chore.create(name: "Living Room")
kitchen = Chore.create(name: "Kitchen")
dr = Chore.create(name: "Dining Room")
br = Chore.create(name: "Bedroom")
porch = Chore.create(name: "Porch")
shoes = Chore.create(name: "Organize Shoes")

c_laundry = Chore.create(name: "Collect Laundry")
wash_laundry = Chore.create(name: "Wash/Dry Laundry")
fold_laundry = Chore.create(name: "Sort/Fold Laundry")
load_dw = Chore.create(name: "Load Dishwasher")
empty_dw = Chore.create(name: "Empty Dishwasher")



# types of chores
# piano - specific users, all days
# living room - rotate weekdays specific users, every user weekends
# kitchen, dining room, porch, shoes - specific users, all days
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: devos.id)
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: mv.id)
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: teeth.id)
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: br.id)
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: water.id)