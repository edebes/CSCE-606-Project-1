# Design
## System Architecture:
Major Classes: AppCLI, Word, WordCLI, TypingSession, Leaderboard, Score

AppCLI is the beginning menu allowing users to access the other menus/classes. Word is the database that stores the wordbank, allowing for users to add, update, remove, and view the words in the bank. WordCLI allows the users to interact with Word functions. TypingSession pulls the words from the Word database to create sentences to practice typing and uploads a leaderboard entry to the Score database. Score is a database that stores the TypingSession details, and Leaderboard takes a combination of time, accuracy, and characters per minute to rank each attempt against each other.

## User Interface Design:
The way it will work when run is the user will have the option to make changes to the word bank, run a practice typing session, or look at the leaderboard using a option list, when the user enters the number associated with any of the options it will allow the user to move to that option. If they choose an option associated with word bank editing or viewing, they will be allowed to make said changes through the terminal with further prompting. If they choose the typing session, then the program will give them a sentence from the words in the word bank to practice typing. The outputted metrics how long the user took to type, accuracy, and characters per minute, and their session will be added to the leaderboard.

## Design Decisions:
We decided to make the app executing in the terminal instead of a webpage because we wanted to make it simpler for the user to view, as running it in the terminal keeps the resources and visuals limited and focused so the user can focus on using the program.
