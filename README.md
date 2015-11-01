# [EpisoPass](http://EpisoPass.com) - Generating passwords from unforgettable episodic memories

![](https://gyazo.com/e5e677f6c0175d82b11a6718a145ebd2.png)

While nobody can remember long strong passwords,
everybody has many secret episodic memories
which he can never forget.
Then why not generating passwords from such
personal episodic memories?

[EpisoPass](http://EpisoPass.com) lets you
generate **very strong** passwords based on your secret
episodic memories. 
If you cannot forget your secret memories,
you have no chance losing your passwords generated from them!

## Basic idea

Artificial long passwords are hard to remember,
while old episodic memories are hard to forget.
If long passwords can be generated from old secret
episodic memories, they are (1) hard to crack, and
(2) easy to be generated from memories.

Users of EpisoPass should provide question-answer
pairs based on their secret episodic memories.
In addition to the correct answer to a question,
users provide wrong answers for each question.
Passwords are calculated from the question-answer pairs,
and passwords generated from correct pairs are used
for various services.

## Example

[This](http://EpisoPass.com/Example/Facebook123)
is an example page of EpisoPass for generating a
Facebook password.
A seed string ("Facebook123") and
two questions are provided,
along with many answer candidates.
A password is generated based on your candidate selections.
If the correct answers are "Palo Alto" and "Atami"
and you select them on the page, you get "Oegvcvzt489",
and you can use it as the password for Facebook.
This is a fairly strong cryptic password string,
and nobody can get this string as long as he does not
know the correct answers to the question.

If you provide many Q-A pairs and a long seed string,
you can generate a long strong password based only on
the seed string and your episodic memories.
If your memories are not know to anybody else,
there's little chance for attackers to get your password,
but you can easily generate it at 
[EpisoPass.com](http://EpisoPass.com/Example/Facebook123)

## Install

- % ```git clone git@github.com:masui/EpisoPass.git```
- % ```sudo gem install sinatra```
- % ```cd EpisoPass```
- Modify ```ROOT``` and ```FILEROOT``` variables
in ```lib/config.rd```
- % ```ruby episopass.rb```
