# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create users, chores, and chore_config records

# users
nate = User.create(name: "Nathanael")
josh = User.create(name: "Joshua")
caleb = User.create(name: "Caleb")
annalise = User.create(name: "Annalise")


# chores

# all users all days
br = Chore.create(name: "Bedroom")
teeth = Chore.create(name: "Brush Teeth After Lunch")
devos = Chore.create(name: "Devotions")
mv = Chore.create(name: "Memory Verse")

# all users, specific days
homework = Chore.create(name: "Homework")

# specific users, all days
lr = Chore.create(name: "Living Room")
kitchen = Chore.create(name: "Kitchen")
dr = Chore.create(name: "Dining Room")
shoes = Chore.create(name: "Organize Shoes")
piano = Chore.create(name: "Piano Practice")

# specific users, specific days

# rotate weekly
trash = Chore.create(name: "Take Trash Out")
empty_dw = Chore.create(name: "Empty Dishwasher")

# rotate daily
fold_laundry = Chore.create(name: "Sort/Fold Laundry")

# not categorized yet
load_dw = Chore.create(name: "Load Dishwasher")
water = Chore.create(name: "Drink Water Bottle")


# chore config
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: devos.id)
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: mv.id)
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: teeth.id)
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: br.id)

ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:rotate_users_each_week], chore_id: trash.id)
ChoreConfig.create(active: true, all_users: true, schedule_type: ChoreConfig.schedule_types[:rotate_users_each_week], chore_id: empty_dw.id)

# create a "last user" for the previous month when initially seeding
ChoreCalendar.create(chore_id: trash.id, user_id: nate.id, chore_date: Time.now.last_month.end_of_month.to_date)
ChoreCalendar.create(chore_id: empty_dw.id, user_id: josh.id, chore_date: Time.now.last_month.end_of_month.to_date)
