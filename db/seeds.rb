# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ---------- USERS ---------- #

nate = User.find_by(name: "Nathanael") || User.create(name: "Nathanael")
josh = User.find_by(name: "Joshua") || User.create(name: "Joshua")
caleb = User.find_by(name: "Caleb") || User.create(name: "Caleb")
annalise = User.find_by(name: "Annalise") || User.create(name: "Annalise")

# ---------- CHORES/CHORE CONFIG ---------- #

# all users all days
br = Chore.find_by(name: "Bedroom") || Chore.create(name: "Bedroom")
teeth = Chore.find_by(name: "Brush Teeth After Lunch") || Chore.create(name: "Brush Teeth After Lunch")
devos = Chore.find_by(name: "Devotions") || Chore.create(name: "Devotions")
mv = Chore.find_by(name: "Memory Verse") || Chore.create(name: "Memory Verse")

ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: devos.id) unless ChoreConfig.find_by(chore_id: devos.id)
ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: mv.id) unless ChoreConfig.find_by(chore_id: mv.id)
ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: teeth.id) unless ChoreConfig.find_by(chore_id: teeth.id)
ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:all_users_all_days], chore_id: br.id) unless ChoreConfig.find_by(chore_id: br.id)

# all users, specific days
homework = Chore.find_by(name: "Homework") || Chore.create(name: "Homework")
ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:all_users_specific_days], chore_id: homework.id, chore_days: "0134") unless ChoreConfig.find_by(chore_id: homework.id)

# specific users, all days
lr = Chore.find_by(name: "Living Room") || Chore.create(name: "Living Room")
kitchen = Chore.find_by(name: "Kitchen") || Chore.create(name: "Kitchen")
dr = Chore.find_by(name: "Dining Room") || Chore.create(name: "Dining Room")
shoes = Chore.find_by(name: "Organize Shoes") || Chore.create(name: "Organize Shoes")
piano = Chore.find_by(name: "Piano Practice") || Chore.create(name: "Piano Practice")

cc1 = ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:specific_users_every_day], chore_id: lr.id) unless ChoreConfig.find_by(chore_id: lr.id)
cc2 = ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:specific_users_every_day], chore_id: kitchen.id) unless ChoreConfig.find_by(chore_id: kitchen.id)
cc3 = ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:specific_users_every_day], chore_id: dr.id) unless ChoreConfig.find_by(chore_id: dr.id)
cc4 = ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:specific_users_every_day], chore_id: shoes.id) unless ChoreConfig.find_by(chore_id: shoes.id)
cc5 = ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:specific_users_every_day], chore_id: piano.id) unless ChoreConfig.find_by(chore_id: piano.id)

# CREATE CHORECONFIGUSERS RECORDS FOR THE SPECIFIC USERS
ChoreConfigUser.create(chore_config_id: cc1.id, user_id: caleb.id) unless ChoreConfigUser.find_by(chore_config_id: cc1.id, user_id: caleb.id)
ChoreConfigUser.create(chore_config_id: cc2.id, user_id: josh.id) unless ChoreConfigUser.find_by(chore_config_id: cc2.id, user_id: josh.id)
ChoreConfigUser.create(chore_config_id: cc3.id, user_id: nate.id) unless ChoreConfigUser.find_by(chore_config_id: cc3.id, user_id: nate.id)
ChoreConfigUser.create(chore_config_id: cc4.id, user_id: annalise.id) unless ChoreConfigUser.find_by(chore_config_id: cc4.id, user_id: annalise.id)
ChoreConfigUser.create(chore_config_id: cc5.id, user_id: nate.id) unless ChoreConfigUser.find_by(chore_config_id: cc5.id, user_id: nate.id)
ChoreConfigUser.create(chore_config_id: cc5.id, user_id: josh.id) unless ChoreConfigUser.find_by(chore_config_id: cc5.id, user_id: josh.id)
ChoreConfigUser.create(chore_config_id: cc5.id, user_id: caleb.id) unless ChoreConfigUser.find_by(chore_config_id: cc5.id, user_id: caleb.id)

# specific users, specific days - NONE

# rotate weekly
trash = Chore.find_by(name: "Take Trash Out") || Chore.create(name: "Take Trash Out")
empty_dw = Chore.find_by(name: "Empty Dishwasher") || Chore.create(name: "Empty Dishwasher")

cc6 = ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:rotate_users_each_week], chore_id: trash.id) unless ChoreConfig.find_by(chore_id: trash.id)
ChoreConfigUser.create(chore_config_id: cc6.id, user_id: nate.id) unless ChoreConfigUser.find_by(chore_config_id: cc6.id, user_id: nate.id)
ChoreConfigUser.create(chore_config_id: cc6.id, user_id: josh.id) unless ChoreConfigUser.find_by(chore_config_id: cc6.id, user_id: josh.id)
ChoreConfigUser.create(chore_config_id: cc6.id, user_id: caleb.id) unless ChoreConfigUser.find_by(chore_config_id: cc6.id, user_id: caleb.id)

ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:rotate_users_each_week], chore_id: empty_dw.id) unless ChoreConfig.find_by(chore_id: empty_dw.id)

# rotate daily - for this rule, set the first day and then have a rule/hook that when one of these get checked, another one gets created
fold_laundry = Chore.find_by(name: "Sort/Fold Laundry") || Chore.create(name: "Sort/Fold Laundry")
ChoreConfig.create(active: true, schedule_type: ChoreConfig.schedule_types[:rotate_users_each_day], chore_id: fold_laundry.id) unless ChoreConfig.find_by(chore_id: fold_laundry.id)

# not categorized yet
load_dw = Chore.find_by(name: "Load Dishwasher") || Chore.create(name: "Load Dishwasher")
water = Chore.find_by(name: "Drink Water Bottle") || Chore.create(name: "Drink Water Bottle")

# create a "last user" for the previous month when initially seeding
ChoreCalendar.create(chore_id: trash.id, user_id: nate.id, chore_date: Time.now.last_month.end_of_month.to_date)
ChoreCalendar.create(chore_id: empty_dw.id, user_id: josh.id, chore_date: Time.now.last_month.end_of_month.to_date)
ChoreCalendar.create(chore_id: fold_laundry.id, user_id: caleb.id, chore_date: Time.now.last_month.end_of_month.to_date)
