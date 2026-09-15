### System Architecture:
Major Classes: Word, (Timer, Scoreboard, Accuracy are all WIP)
Word is the database that stores the wordbank, allowing for users to add, update, remove, and view the words in the bank. The typing program pulls the words from the database to create sentences to practice typing. Timer both displays the time as the user is typing and stores the final time taken to complete the sentence. Accuracy maintains the ratio of correct characters typed to total characters, and Scoreboard takes a combination of Timer and Accuracy to rank each attempt against each other.

### User Interface Design:
The way it will work when run is the user will have the option to make changes to the word bank or run a practice typing session using a option list, when the user enters the number associated with any of the options it will allow the user to move to that option. If they choose an option associated with wordbank editing or viewing, they will be allowed to make said changes through the terminal with further promting. If they choose the typing session, then the program will give them a sentence from the words in the wordbank to practice typing (WIP). The score is recorded as a mixture of the timer and accuracy, and then displayed on the leaderboard (WIP).

### Design Decisions:
We decided to make the app executing in the terminal instead of a webpage because we wanted to make it simpler for the user to view, as running it in the terminal keeps the resources and visuals limited and focused so the user can focus on using the program.
