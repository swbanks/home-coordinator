# Next Steps

Need remove chore for user for day/week/month
Expand the add/remove chore to do it in the UI. We can have a dropdown for users, chores, and frequency
Add the ability to add a chore from the UI

Chore changes:
- Need cubbies
- load dishes
- remove memory verse
- load laundry
- sort and put away laundry
- clean bathroom
- weedwhack - maybe just add it and assign on a given day
- mow
- make lunch for tomorrow
- set out clothes for tomorrow

1. Password protect the parent login (do not need a username)
    - use the *s 
1. Method for "get today's chore status for user" - returns chore and status
1. Use dropdown for Child login instead of text field
1. Add/remove chores that I want them to do
    - cubbies
    - turning laundry inside out
    - remove memory verse
    - what else?
1. Allow the parent view to have the date associated with it
1. Being able to navigate to the next and previous day in a single month
1. Create some utility functions - figure out what I would want these to be
    - are there any chores this month?
    - add button to create chores for the month
    - find all chores for one person for TODAY
    - who has X chore today?
1. Navigation to the correct page 
1. Need a loader for png files because of the background image
1. Get background image working
1. Add interface where we can show how much time they have on devices, check for if they did chores w/o being told, more info they can add, etc
1. Add a counter on their screen so they can time their screen time - https://www.geeksforgeeks.org/how-to-create-a-countdown-timer-using-reactjs/
1. If the kid clicks the last chore to be finished, they must save before displaying the fireworks

# Different Tech

1. Consider using Redux for state management so I can use the back button and load the proper state each time
1. Attempt to use GraphQL for one request
1. Add Typescript to the mix
1. Add some unit testing to the front end and back end
1. Start to add very minimal E2E testing using Cypress

# Later

1. Calculate allowance based on them checking off their chores (and getting checked by parents)
1. List of other things to check for the day, like if we had to ask them to do chores, games before chores, if they ate fruit, how much they purchased at school, etc.
