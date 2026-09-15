# CSCE-606-Project-1
This program lets you create a word bank with the ability to add, edit and delete words from the bank as well as perform a typing test to see how fast you can type given words.

### Project Name:
TypeNinja

### Description:
This is a typing app that allows users to maintain a wordbank of words they want to get better at typing and practice with all of those words. It will track the user’s speed and accuracy of their typing so they can reflect on how they have improved.

### Installation:
To run this program, you must have ruby 3.4.10 installed on your device and a Linux environment. To get the program, clone this repo into the Linux environment.

### Running the app:
To run the app, enter "ruby bin/app.rb" into the terminal and press enter, then the program will boot up into the main menu. Numbered options will appear, and the user enters the number of the option into the terminal. If the option was wordbank related, then the user will follow the prompts displayed to them. If they choose the typing practice, a sentence will be displayed to them with a timer counting up, and the user will have to type the sentence as fast as they can. After they finish the session, they will be shown their score based on a mix of their accuracy and time, as well as how they ranked on the leaderboard of previous attempts. If they wish to exit, they can enter the number to exit or press escape.

### Running the Tests and Coverage Report:
To run the tests, enter "bin/rspec -fd", and to get the coverage report, enter "bin/rspec -fd -o Coverage_Report.txt spec/" into the terminal.

### Main Features:
The main features include:

- Viewing, Adding, Updating, and Deleting words to the wordbank
- Create sentences with wordbank words for the user to practice typing
- Timer to record user's speed of typing
- Accuracy to record the user's correct characters/total characters ratio

### Known Limitations:
We are building the program to be run in the terminal, meaning that all visuals, functionality, and control must be contained within the terminal. 

### Member Names:
Alex Gonce,
Eric Debes
